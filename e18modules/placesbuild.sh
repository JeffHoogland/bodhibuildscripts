#!/bin/sh

cd /home/jeff/e17_src/places && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/places /media/sda5/Bodhi/e17_debs/$1/places-e18_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/places-e18_$1.tar.gz places-e18_$1/

cd /media/sda5/Bodhi/e17_debs/$1/places-e18_$1
make distclean
dh_make -p places-e18_$1 -e jeffhoogland@linux.com -f ../places-e18_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/places-e18/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../places*.deb
