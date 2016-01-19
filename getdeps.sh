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
# Check for sudo
chksu="$(whoami)"
if [ "$chksu" != "root" ]; then
    echo "Needs to be run as sudo..."
    echo "USAGE: sudo ./getdebs.sh {package-name}"
    exit
fi

# Vars
pkg="$(which "$1")"
charset="$(file --mime /usr/bin/"$1" | grep binary | awk '{ print $3 }' | sed -e 's/charset=//g')"

getlist() {
    objdump -p "$pkg" | grep NEEDED | sed -e 's/NEEDED//g' > tmp
    sed "s/^[ \t]*//" -i tmp
    list=($(<tmp)); dpkg -S "${list[@]}" > list
    awk '{ print $1 }' list | sed -e 's/i386://g' | sort | uniq
    rm list
    rm tmp
exit
}
# binary
getlistbin() {
    dll "$pkg"
}
# error
geterr() {
    echo "Package $1 not installed, or not specified...can't get dependecy list..."
    echo "USAGE: sudo ./getdebs.sh {package-name}"
exit
}
# check for ./configure in source dir and interrogate.
if [ -e configure ]; then
    sudo dpkg-depcheck -d ./configure
fi
# check if package is installed, interrogate and parse
if [ -e "$pkg" ]; then
    echo "Checking file type..."
getlist
else
geterr "$@"
fi
# check for binary
if [ "$charset" = "binary" ]; then
getlistbin "$@"
else
getlist "$0"
fi
