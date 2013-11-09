#!/bin/sh

cd /home/jeff/e17_src/notification && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/notification /media/sda5/Bodhi/e17_debs/$1/notification-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/notification-$1.tar.gz notification-$1/

cd /media/sda5/Bodhi/e17_debs/$1/notification-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../notification-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/notification/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../notification*.deb
