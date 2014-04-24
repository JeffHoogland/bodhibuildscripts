#!/bin/sh

cd /home/jeff/e17_src/everything-places && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/everything-places /media/sda5/Bodhi/e17_debs/$1/everything-places_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/everything-places_$1.tar.gz everything-places_$1/

cd /media/sda5/Bodhi/e17_debs/$1/everything-places_$1
dh_make -p everything-places_$1 -e jeffhoogland@linux.com -f ../everything-places_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/everything-places/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../everything-places*.deb
