#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cp -R ../../$2/ecrire-$2 ../../bodhi_debs/$1/ecrire-$1

cd ../../bodhi_debs/$1
tar czvf ecrire-$1.tar.gz ecrire-$1/

cd ecrire-$1
dh_make -e jeffhoogland@linux.com -f ../ecrire-$1.tar.gz

cp ../../../bodhibuildscripts/controlfiles/ecrire/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../ecrire*.deb
