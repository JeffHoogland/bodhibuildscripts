#!/bin/bash
# Script to get dependencies for building deb fils

# get list of libs for application and find package names for deps
#
# Todo
# - Implement dll for binaries and  elf binary support > get elf/dll file to test and work out parse params
# - Add i686 for list parse > array
# - Odness - test $file -v /usr/bin/esudo --wtf?
#

# Vars
pkg="$(which "$1")"
#charset="$(file --mime /usr/bin/"$1" | grep binary | awk '{ print $3 }' | sed -e 's/charset=//g')"

getlist() {
    objdump -p "$pkg" | grep NEEDED | sed -e 's/NEEDED//g' > tmp
	if [ $? -eq 0 ]; then
    	sed "s/^[ \t]*//" -i tmp
    	list=($(<tmp)); dpkg -S "${list[@]}" > list
    	awk '{ print $1 }' list | sed -e 's/i386://g' | sort | uniq
	rm list
	rm tmp
	else
	gelitshbin
	fi
}
# binary
getlistbin() {
#sudo apt-get build-dep $1 | cat tmp | grep NEEDED
    readelf -d "$pkg" | grep NEEDED
	if [ $? -eq 1 ]; then
	    ldd "$pkg"
	    if [ $? -eq 1 ]; then
	geterr
	    fi
	fi
}
# error
geterr() {
    echo "Binary type not supported or not recognised..."
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
