#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cd ~/$2/evas_generic_loaders-$2 && make distclean
./autogen.sh
cp -R ~/$2/evas_generic_loaders-$2 ../../bodhi_debs/$1/evas-generic-loaders_$1
cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/evas-generic-loaders_$1.tar.gz evas-generic-loaders_$1/

cd ../../bodhi_debs/$1/evas-generic-loaders_$1
dh_make -p evas-generic-loaders_$1 -e "Eric W. Brown (Feneric)" -f ../evas-generic-loaders_$1.tar.gz

cp ../controlfiles/evas-generic-loaders/* debian/
dpkg-buildpackage -rfakeroot
sudo dpkg -i ../evas-generic-loaders*.deb
