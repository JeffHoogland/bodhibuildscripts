#!/bin/sh

mkdir -p ../../bodhi_debs/$1

#Normal package
cp -R ~/$2/enlightenment-$2 ../../bodhi_debs/$1/e19-$1

cd ../../bodhi_debs/$1/e19-$1
patch -p1 < ../patches/bodhi_e19.diff

./autogen.sh

cd ../../bodhi_debs/$1
tar czvf e19-$1.tar.gz e19-$1/

cd ../../bodhi_debs/$1/e19-$1
autoreconf
make distclean
dh_make -e "Eric W. Brown (Feneric)" -f ../e19-$1.tar.gz

cp -f ../controlfiles/e19/* debian/
dpkg-buildpackage -rfakeroot -b
sudo dpkg -i ../e19*.deb
