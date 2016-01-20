#!/bin/sh
# Usage:
#  genericbuild.sh <package name> <version number>
# Example:
#  sh genericbuild.sh terminology enlightenment
#
# Todo
# - call and add results of getdeps.sh to add to control file()
#
# Updated 20/01/15
# Hipptaff

err() {
    echo "USAGE: sudo ./genericbuild.sh <package name> <version number>"
    exit
}

# Check process (autogen/autoreconf)
chkproc() {
sudo /$1./autogen.sh
if [ $? = 1 ]; then
    autoreconf
    if [ $? = 1 ]; then
    echo "No autogen,sh or autoreconf...bailing"
    echo "Are you in /home?"
    else
    dhmake
    exit 1
    fi
fi
}

# Make tar and folder structure (add maintainer name - make var?)
dhmake() {
dh_make -e "Gareth Williams <hippytaff@gmail.com>" -f $1-$2.tar.gz
if [ $? = 1 ]; then
    echo "dh_make failed..."
    err
else
    cpctrl
fi
}

# Copy control file to /debain - Add check /debian for new control (timestamp?)
cpctrl() {
cp -f controlfiles/$1/* debian/
if [ $? = 1 ]; then
    echo "Failed to copy comtrol file..."
    err
else
    build
fi
}

# Build .deb
build() {
dpkg-buildpackage -rfakeroot -b
if [ $? = 1 ]; then
    echo "Build failed..."
    err
else
    test
fi
}

# Test .deb
test() {
dpkg -i ../$1*.deb
if [ $? = 1 ]; then
    echo "Failed to copy comtrol file..."
    err
else
    echo "Success..."
fi
}

# Check for sudo
suchk="$(whoami)"
if [ $suchk = "root" ]; then
    chkproc
else
    err
fi
exit

