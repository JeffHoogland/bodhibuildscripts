#!/bin/sh

cd /home/jeff/e17_src/comp-scale && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/comp-scale /media/sda5/Bodhi/e17_debs/$1/comp-scale-e18_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/comp-scale-e18_$1.tar.gz comp-scale-e18_$1/


cd /media/sda5/Bodhi/e17_debs/$1/comp-scale-e18_$1
dh_make -p comp-scale-e18_$1 -e jeffhoogland@linux.com -f ../comp-scale-e18_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/comp-scale-e18/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../comp-scale*.deb
