#!/bin/bash
# Script to get dependencies for building deb fils

# get list of libs for application and find package names for deps
#
# Todo
# implement readelf for ELF binaries or sudo apt-get source?
# add i686 for list parse > array
# check for sudo > sigh

# Check for sudo
CHKSU="$(whoami)"
if [ "$CHKSU" != "root" ]; then
    echo "Needs to be run as sudo..."
    echo "USAGE: sudo ./getdebs.sh {package-name}"
    exit
fi


# check for ./configure in source dir and interrogate.

if [ -e configure ]; then
    sudo dpkg-depcheck -d ./configure
fi

# Vars
PKG="$(which $1)"

# check if package is installed, interrogate with objdump and parse
if [ -e $PKG ]; then
    objdump -p $PKG | grep NEEDED | sed -e 's/NEEDED//g' > tmp
    LIB="$(cat tmp)"
    dpkg -S $LIB > list
    rm tmp
    awk '{ print $1 }' list | sort | uniq | sed -e 's/i386://g'
    rm list
else
    echo "Package $1 not installed, or not specified...can't get dependecy list..."
    echo "USAGE: sudo ./getdebs.sh {package-name}"
fi

