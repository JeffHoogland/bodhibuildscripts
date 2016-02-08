#!/bin/sh
# Usage:
#   genericbuild.sh <package name> <version number> <maintainer>
# Example:
#   genericbuild.sh terminology enlightenment Gareth Williams
#
# Notes:
# - Needs /control, getdeps.sh and installdeps.sh
#
# Todo
# - Call and add results of getdeps.sh to add to control file()
# - Maintainer var
# -
# Updated 20/01/15
# Hipptaff

# Vars
pkg="$1"
ver="$2"
mail="$3"

err() {
    echo "Usage: sudo ./genericbuild.sh <package name> <version number> <maintainer>"
    echo
    exit
}

# Test .deb
test() {
dpkg -i ../"$pkg*".deb
if [ "$?" -eq 1 ]; then
    echo "Failed to install "$1"..."
    err
else
    echo "Success..."
fi
}

# Build .deb
build() {
dpkg-buildpackage -r fakeroot -b
if [ "$?" -eq 1 ]; then
    echo "Build failed..."
    err
else
    test
fi
}

# Copy control file to /debain
cpctrl() {
cp -f controlfiles/"$pkg"/* debian/
if [ "$?" -eq 1 ]; then
    echo "Failed to copy control file..."
    err
else
    cat debian/control sed -e 's/root/"$1"/s'
    build
fi
}

# Make tar and folder structure (add maintainer name - make var?)
dhmake() {
dh_make -e "<"$mail"@bodhilinux.com>" -f "$pkg"*.tar.gz
if [ "$?" -eq 1 ]; then
    echo "dh_make failed..."
    err
else
    cpctrl
fi
}

# Check for autogen and autoreconf
chkproc() {
./autogen.sh
if [ "$?" -eq 1 ]; then
    echo "No autogen.sh...bailing"
    echo "Are you in the right directory?"
else
autoreconf
fi
if [ "$?" -eq 1 ]; then
    echo "No autoreconf...bailing"
    echo "Are you in the right directory?"
else
    dhmake
fi
}

# Check input vars
reqvar() {
if [ -z "$pkg" ]; then
    err
    else
    chkproc
fi
}

# Check for sudo
suchk="$(whoami)"
if [ "$suchk" != "root" ]; then
    echo "Needs to be run as root..."
    err
    else
    reqvar
fi
