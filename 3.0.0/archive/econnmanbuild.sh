#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cd ../../$2/econnman-$2 && make distclean
autoreconf
cp -R ../../$2/econnman-$2 ../../bodhi_debs/$1/econnman-$1
cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/econnman-$1.tar.gz econnman-$1/


cd ../../bodhi_debs/$1/econnman-$1
make distclean
dh_make -e "Jeff Hoogland" -f ../econnman-$1.tar.gz

cp ../controlfiles/econnman/control debian/
dpkg-buildpackage -rfakeroot
#sudo dpkg -i ../econnman*.deb
