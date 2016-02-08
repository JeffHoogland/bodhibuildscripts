#!/bin/bash
# Script to get dependencies for building deb fils
#
# get list of libs for application and find package names for deps
#
# Todo
# - Add i686 for list parse > array
# - Integrate with genericbuild.sh to polulate control file deps.
#
# Note: As far as I know all readable bin types are supported by this script. Some binary's cannot be interrogated
#	 commonly used tools, if at all without decompiling, which is unlikey to happen for this script. For those
#	 files and old fasioned search for dependancies will have to do.


# Vars
pkg="$(which "$1")"
chksu="$(whoami)"

getlist() {
    objdump -p "$pkg" | grep NEEDED | sed -e 's/NEEDED//g' > tmp
	if [ $? -eq 0 ]; then
    	sed "s/^[ \t]*//" -i tmp
    	list=($(<tmp)); dpkg -S "${list[@]}" > list
    	awk '{ print $1 }' list | sed -e 's/i386://g' | sed -e 's/i686://g' | sort | uniq
	rm list
	rm tmp
	else
	geterr
	fi
}
# ELF binary
getlistbin() {
    readelf -V "$pkg" | grep lib*
	if [ $? -eq 1 ]; then
	    ldd "$pkg"
	    if [ $? -eq 1 ]; then
	geterr
	    fi
	fi
}
# error
geterr() {
    echo "File type not supported or not recognised..."
exit
}
# Start #
# Check for sudo
if [ "$chksu" != "root" ]; then
    echo "Needs to be run as sudo..."
    echo "USAGE: sudo ./getdebs.sh {package-name}"
    exit
fi

if [ -e configure ]; then
    sudo dpkg-depcheck -d ./configure
fi

# check if objdump can interrogate bin, if not try getelf and ldd
objdump -p "$pkg" > /dev/null 2>&1
if [ "$?" -eq 0 ]; then
    getlist
    else
    getlistbin
fi

