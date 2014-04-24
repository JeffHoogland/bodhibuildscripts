#!/bin/sh

cd /home/jeff/e17_src/enjoy && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/enjoy /media/sda5/Bodhi/e17_debs/$1/enjoy-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/enjoy-$1.tar.gz enjoy-$1/

cd /media/sda5/Bodhi/e17_debs/$1/enjoy-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../enjoy-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/enjoy/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../enjoy*.deb
