#!/bin/sh

cd /home/jeff/e17_src/places && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/places /media/sda5/Bodhi/e17_debs/$1/places-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/places-$1.tar.gz places-$1/

cd /media/sda5/Bodhi/e17_debs/$1/places-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../places-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/places/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../places*.deb
