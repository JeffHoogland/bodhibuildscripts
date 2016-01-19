#!/bin/sh
#Usage:
# genericbuild.sh <output version> <source version> <source name>
#Example:
# sh genericbuild.sh 20150101 git enlightenment

mkdir -p ../bodhi_debs/$1

#If we are building from git, folder name is different structure
if test "$2" = "git"
then
    cd ../$2/$3
    ./autogen.sh

    cp -R ../../$2/$3 ../../bodhi_debs/$1/$3-$1
else
    cd ../$2/$3-$2
    autoreconf

    cp -R ../../$2/$3-$2 ../../bodhi_debs/$1/$3-$1
fi

cd ../../bodhi_debs/$1
tar czvf $3-$1.tar.gz $3-$1/

cd $3-$1
dh_make -e "Gareth Williams <hippytaff@gmail.com>" -f ../$3-$1.tar.gz

cp -f ../../../bodhibuildscripts/controlfiles/$3/* debian/

dpkg-buildpackage -rfakeroot -b
dpkg -i ../$3*.deb
