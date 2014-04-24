#!/bin/sh

cd /home/jeff/e17_src/edbus && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/edbus /media/sda5/Bodhi/e17_debs/$1/edbus2-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/edbus2-$1.tar.gz edbus2-$1/

cd /media/sda5/Bodhi/e17_debs/$1/edbus2-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../edbus2-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/edbus2/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../edbus2*.deb
