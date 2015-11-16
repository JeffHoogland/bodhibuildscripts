#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cd ../../$2/efx-$2
autoreconf

cp -R ../../$2/efx-$2 ../../bodhi_debs/$1/efx-$1
cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/efx-$1.tar.gz efx-$1/

cd ../../bodhi_debs/$1/efx-$1
dh_make -e "Jeff Hoogland <jeffhoogland@linux.com>" -f ../efx-$1.tar.gz
make distclean
cp ../controlfiles/efx/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../efx*.deb
