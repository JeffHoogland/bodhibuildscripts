#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cd ../../$2/places-$2
autoreconf

cp -R ../../$2/places-$2 ../../bodhi_debs/$1/places-$1
cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/places-$1.tar.gz places-$1/

cd ../../bodhi_debs/$1/places-$1
dh_make -e "Jeff Hoogland <jeffhoogland@linux.com>" -f ../places-$1.tar.gz
make distclean
cp ../controlfiles/places/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../places*.deb
