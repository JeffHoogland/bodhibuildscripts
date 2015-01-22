#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cd ../../$2/terminology-$2 && make distclean
autoreconf
cp -R ../../$2/terminology-$2 ../../bodhi_debs/$1/terminology-$1
cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/terminology-$1.tar.gz terminology-$1/


cd ../../bodhi_debs/$1/terminology-$1
make distclean
dh_make -e "Jeff Hoogland" -f ../terminology-$1.tar.gz

cp ../controlfiles/terminology/control debian/
dpkg-buildpackage -rfakeroot
sudo dpkg -i ../terminology*.deb
