#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cp -R /home/jeff/git/epulse-git ../../bodhi_debs/$1/epulse-e19_$1
cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/epulse-e19_$1.tar.gz epulse-e19_$1/

cd ../../bodhi_debs/$1/epulse-e19_$1
make distclean
dh_make -p epulse-e19_$1 -e jeffhoogland@linux.com -f ../epulse-e19_$1.tar.gz

cp ../controlfiles/epulse-e19/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../epulse-e19*.deb
