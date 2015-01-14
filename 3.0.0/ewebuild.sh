#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cp -R /home/jeff/$2/ewe-$2 ../../bodhi_debs/$1/ewe-$1
cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/ewe-$1.tar.gz ewe-$1/

cd ../../bodhi_debs/$1/ewe-$1
dh_make -e jeffhoogland@linux.com -f ../ewe-$1.tar.gz
make distclean
cp ../controlfiles/ewe/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../ewe*.deb

#cp -R /home/jeff/$2/ewe-$2 ../../bodhi_debs/$1/ewe-dbg_$1
#cd ../../bodhi_debs/$1
#tar czvf ../../bodhi_debs/$1/ewe-dbg_$1.tar.gz ewe-dbg_$1/

#cd ../../bodhi_debs/$1/ewe-dbg_$1
#dh_make -p ewe-dbg_$1 -e jeffhoogland@linux.com -f ../ewe-dbg_$1.tar.gz
#make distclean
#cp ../controlfiles/ewe-dbg/* debian/
#dpkg-buildpackage -rfakeroot -b
