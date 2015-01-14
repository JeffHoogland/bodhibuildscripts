#!/bin/sh

mkdir -p ../../bodhi_debs/$1

#Normal package
cp -R ~/$2/enlightenment-$2 ../../bodhi_debs/$1/e18-$1

cp /media/sda5/Bodhi/patches/e18/illume-keyboard/* ../../bodhi_debs/$1/e18-$1/src/modules/illume-keyboard/keyboards/

cd ../../bodhi_debs/$1
tar czvf e18-$1.tar.gz e18-$1/

cd ../../bodhi_debs/$1/e18-$1
autoreconf
make distclean
dh_make -e jeffhoogland@linux.com -f ../e18-$1.tar.gz

cp -f ../controlfiles/e18/* debian/
dpkg-buildpackage -rfakeroot -b
sudo dpkg -i ../e18*.deb
