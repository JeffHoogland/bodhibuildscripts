#!/bin/bash
# Script to get dependencies for building deb fils

# get list of libs for application

PKG=$1
objdump -p /usr/bin/$1 | grep NEEDED | sed -e 's/NEEDED//g' > tmp
LIB="$(cat tmp)"
dpkg -S $LIB > list
rm tmp
awk '{ print $1 }' list | sort | uniq


