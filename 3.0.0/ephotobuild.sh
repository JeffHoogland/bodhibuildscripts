#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cd ../../$2/ephoto-$2 && make distclean
autoreconf
cp -R ../../$2/ephoto-$2 ../../bodhi_debs/$1/ephoto-$1
cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/ephoto-$1.tar.gz ephoto-$1/


cd ../../bodhi_debs/$1/ephoto-$1
make distclean
dh_make -e "Jeff Hoogland" -f ../ephoto-$1.tar.gz

cp ../controlfiles/ephoto/control debian/
dpkg-buildpackage -rfakeroot
#sudo dpkg -i ../ephoto*.deb
