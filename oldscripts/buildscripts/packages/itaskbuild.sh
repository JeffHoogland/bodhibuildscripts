#!/bin/sh

cd /home/jeff/e17_src/itask && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/itask /media/sda5/Bodhi/e17_debs/$1/itask-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/itask-$1.tar.gz itask-$1/

cd /media/sda5/Bodhi/e17_debs/$1/itask-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../itask-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/itask/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../itask*.deb
