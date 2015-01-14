#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cd ~/$2/enlightenment-$2
autoreconf

cp -R ~/$2/enlightenment-$2 ../../bodhi_debs/$1/e17-$1

cd ../../bodhi_debs/$1/e17-$1
patch -p1 < ../patches/bodhi_e17.diff

cd ../../bodhi_debs/$1
tar czvf e17-$1.tar.gz e17-$1/

cd ../../bodhi_debs/$1/e17-$1
make distclean
dh_make -e "Doug Yanez <deepspeed@bodhilinux.com>" -f ../e17-$1.tar.gz

cp -f ../controlfiles/e17/* debian/
dpkg-buildpackage -rfakeroot -b
sudo dpkg -i ../e17*.deb
