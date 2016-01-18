#!/bin/bash
# Script to get dependencies for building deb fils

# get list of libs for application and find package names for deps
#
# Todo
# objdump for bins - http://www.askrprojects.net/software/objdump.html
# check ./configure first
# add i686 for list parse

# check for ./configure in source dir and interrogate.
#if [ -f 

# Vars
PKG="$(which $1)"

# check if package is installed, interrogate with objdump and parse
if [ -z $PKG ]; then
    echo "Package $1 not installed, or not specified...can't check get dependecy list..."
    exit
    else
    objdump -p /usr/bin/$1 | grep NEEDED | sed -e 's/NEEDED//g' > tmp
    LIB="$(cat tmp)"
	if [ $? != 0 ]; then
	touch temp.c
	gcc -c -o temp.o temp.c
	objcopy --add-section raw=$1.bin temp.o
	objcopy -R .comment temp.o
	objdump -d temp.o
	else
    dpkg -S $LIB > list
    rm tmp
    awk '{ print $1 }' list | sort | uniq | sed -e 's/i386://g'
    rm list
	fi
fi

