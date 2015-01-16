#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cd ../../$2/enlightenment-$2
autoreconf

#Normal package
cp -R ../../$2/enlightenment-$2 ../../bodhi_debs/$1/e20-$1

cd ../../bodhi_debs/$1/e20-$1
#patch -p1 < ../../../bodhibuildscripts/patches/bodhi_e19.diff

cd ..
tar czvf e20-$1.tar.gz e20-$1/

cd e20-$1
dh_make -e "Jeff Hoogland" -f ../e20-$1.tar.gz

cp -f ../../../bodhibuildscripts/controlfiles/e20/* debian/
dpkg-buildpackage -rfakeroot -b
sudo dpkg -i ../e20*.deb
