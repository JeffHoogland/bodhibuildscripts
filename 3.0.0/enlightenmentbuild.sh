#!/bin/bash

# The script takes one argument: the build scripts repository path.
if [ $# -gt 0 ]; then
    BUILD_SCRIPTS_DIR=$1
else
    BUILD_SCRIPTS_DIR=~/bodhibuildscripts
fi

# e17 probably won't be getting version releases anymore, make this a script
# arg if that changes.
BASE_VERSION="0.17.6"

if [ -n "${DEBEMAIL:-x}" ]; then
    echo -e "\e[31mDEBEMAIL empty or not set, using a default value\e[0m"
    DEBEMAIL="maintainer@bodhilinux.com"
    export DEBEMAIL
fi

if [ -n "${DEBFULLNAME:-x}" ]; then
    echo -e "\e[31mDEBFULLNAME empty or not set, using a default value\e[0m"
    DEBFULLNAME="Bodhi Linux"
    export DEBFULLNAME
fi

echo
cd ~/enlightenment

if GIT_VERSION=$(git rev-parse --short HEAD); then
    GIT_VERSION="+${GIT_VERSION}"
    git clean -xdf || exit $?
    git checkout . || exit $?
    git pull || exit $?
    ./autogen.sh || exit $?
else # not in git
    GIT_VERSION=""
fi

# Clean up files from a previous build
rm -v ../enlightenment_${BASE_VERSION}${GIT_VERSION}-1_i386.deb || echo -e "\e[32mOld .deb file not removed!\e[0m"

# Create distribution tarballs and move to ..
make dist || exit $?
mv *.tar.* ..

# Patch after the original tarball is created, diff is then kept in the package
patch -p1 < ${BUILD_SCRIPTS_DIR}/patches/bodhi_e17.diff || exit $?

# e17 still believes it's living in svn and fails to append the commit
# revision to the version string in tarball and e's about dialog.
#
# We get the git commit id manually and append it to the package version.
dh_make -y -m \
    -f ../enlightenment-${BASE_VERSION}.tar.gz \
    -p enlightenment_${BASE_VERSION}${GIT_VERSION} \
    -t ${BUILD_SCRIPTS_DIR}/controlfiles/enlightenment \
    -c bsd \
    || exit $?

if [ -n "${EDITOR:-x}" ]; then
    EDITOR="nano -w"
fi
echo -e "\a"
$EDITOR debian/control

dpkg-buildpackage -rfakeroot -b || exit $?

echo -e "\e[33mEnlightenment $BASE_VERSION$GIT_VERSION built succesfully!\e[0m"
echo -e "\a"
exit
