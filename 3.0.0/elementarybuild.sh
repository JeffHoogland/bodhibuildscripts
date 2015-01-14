#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cp -R ~/$2/elementary-$2 ../../bodhi_debs/$1/elementary-$1
cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/elementary-$1.tar.gz elementary-$1/

cd ../../bodhi_debs/$1/elementary-$1
dh_make -e "Eric W. Brown (Feneric)" -f ../elementary-$1.tar.gz
make distclean
cp ../controlfiles/elementary/* debian/
dpkg-buildpackage -rfakeroot -b
sudo dpkg -i ../elementary*.deb

#cp -R ~/$2/elementary-$2 ../../bodhi_debs/$1/elementary-dbg_$1
#cd ../../bodhi_debs/$1
#tar czvf ../../bodhi_debs/$1/elementary-dbg_$1.tar.gz elementary-dbg_$1/

#cd ../../bodhi_debs/$1/elementary-dbg_$1
#dh_make -p elementary-dbg_$1 -e "Eric W. Brown (Feneric)" -f ../elementary-dbg_$1.tar.gz
#make distclean
#cp ../controlfiles/elementary-dbg/* debian/
#dpkg-buildpackage -rfakeroot -b
