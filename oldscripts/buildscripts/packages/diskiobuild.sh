#!/bin/sh

cd /home/jeff/e17_src/diskio && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/diskio /media/sda5/Bodhi/e17_debs/$1/diskio-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/diskio-$1.tar.gz diskio-$1/

cd /media/sda5/Bodhi/e17_debs/$1/diskio-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../diskio-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/diskio/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../diskio*.deb
