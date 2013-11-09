#!/bin/sh

cd /home/jeff/e17_src/azy && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/azy /media/sda5/Bodhi/e17_debs/$1/azy-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/azy-$1.tar.gz azy-$1/

cd /media/sda5/Bodhi/e17_debs/$1/azy-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../azy-$1.tar.gz
cp /media/sda5/Bodhi/e17_debs/controlfiles/azy/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../azy*.deb
