#!/bin/bash
# Script to get dependencies for building deb fils

# get list of libs for application and find package names for deps
#
# Todo
# implement dll for binaries
# elf binary support
# add i686 for list parse > array
# check for sudo > sigh
# test file -v /usr/bin/esudo --wtf?
#

# Vars
pkg="$(which "$1")"
#charset="$(file --mime /usr/bin/"$1" | grep binary | awk '{ print $3 }' | sed -e 's/charset=//g')"

getlist() {
    objdump -p "$pkg" | grep NEEDED | sed -e 's/NEEDED//g' > tmp
    sed "s/^[ \t]*//" -i tmp
    list=($(<tmp)); dpkg -S "${list[@]}" > list
    awk '{ print $1 }' list | sed -e 's/i386://g' | sort | uniq
    rm list
    rm tmp
}
# binary
getlistbin() {
#    sudo apt-get build-dep $1 | cat tmp | grep NEEDED
    readelf -d "$pkg" | grep NEEDED
#    ldd $pkg
}
# error
geterr() {
    echo "Package $1 not installed, or not specified...can't get dependecy list..."
    echo "USAGE: sudo ./getdebs.sh {package-name}"
exit
}
# Start #
# Check for sudo
chksu="$(whoami)"
if [ "$chksu" != "root" ]; then
    echo "Needs to be run as sudo..."
    echo "USAGE: sudo ./getdebs.sh {package-name}"
    exit
fi

if [ -e configure ]; then
    sudo dpkg-depcheck -d ./configure
fi

# check if file binary
objdump -p "$pkg" > /dev/null 2>&1
if [ "$?" -eq 0 ]; then
    getlist
    else
    getlistbin
fi
