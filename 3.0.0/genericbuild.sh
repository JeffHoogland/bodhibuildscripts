#!/bin/sh

mkdir -p ../../bodhi_debs/$1

#If we are building from git, folder name is different structure
if test "$2" = "git"
then
    cd ../../$2/$3
    autoreconf

    cp -R ../../$2/$3 ../../bodhi_debs/$1/$3-$1
else
    cd ../../$2/$3-$2
    autoreconf

    cp -R ../../$2/$3-$2 ../../bodhi_debs/$1/$3-$1
fi

cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/$3-$1.tar.gz $3-$1/

cd ../../bodhi_debs/$1/$3-$1
dh_make -e jeffhoogland@linux.com -f ../$3-$1.tar.gz
make distclean
cp ../controlfiles/$3/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../$3*.deb
