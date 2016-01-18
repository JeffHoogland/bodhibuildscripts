#!/bin/bash
# Script to get dependencies for building deb fils

# get list of libs for application
# if package is installed check /usr/bin/

PKG="$(which $1)"
objdump -p /usr/bin/$1 | grep NEEDED | sed -e 's/NEEDED//g' > tmp
LIB="$(cat tmp)"
dpkg -S $LIB > list
rm tmp
awk '{ print $1 }' list | sort | uniq | sed -e 's/i386://g'
rm list

