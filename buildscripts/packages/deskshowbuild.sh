#!/bin/sh

cd /home/jeff/e17_src/deskshow && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/deskshow /media/sda5/Bodhi/e17_debs/$1/deskshow-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/deskshow-$1.tar.gz deskshow-$1/

cd /media/sda5/Bodhi/e17_debs/$1/deskshow-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../deskshow-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/deskshow/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../deskshow*.deb
