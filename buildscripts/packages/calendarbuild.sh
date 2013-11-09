#!/bin/sh

cd /home/jeff/e17_src/calendar && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/calendar /media/sda5/Bodhi/e17_debs/$1/calendar-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/calendar-$1.tar.gz calendar-$1/

cd /media/sda5/Bodhi/e17_debs/$1/calendar-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../calendar-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/calendar/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../calendar*.deb
