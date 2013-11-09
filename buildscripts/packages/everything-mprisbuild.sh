#!/bin/sh

cd /home/jeff/e17_src/everything-mpris && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/everything-mpris /media/sda5/Bodhi/e17_debs/$1/everything-mpris_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/everything-mpris_$1.tar.gz everything-mpris_$1/


cd /media/sda5/Bodhi/e17_debs/$1/everything-mpris_$1
dh_make -p everything-mpris_$1 -e jeffhoogland@linux.com -f ../everything-mpris_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/everything-mpris/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../everything-mpris*.deb
