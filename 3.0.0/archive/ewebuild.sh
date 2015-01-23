#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cd ../../$2/ewe-$2
autoreconf

cp -R ../../$2/ewe-$2 ../../bodhi_debs/$1/ewe-$1
cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/ewe-$1.tar.gz ewe-$1/

cd ../../bodhi_debs/$1/ewe-$1
dh_make -e "Jeff Hoogland <jeffhoogland@linux.com>" -f ../ewe-$1.tar.gz
make distclean
cp ../controlfiles/ewe/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../ewe*.deb
