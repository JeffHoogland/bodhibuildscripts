#!/bin/sh

cd /home/jeff/e17_src/everything-pidgin && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/everything-pidgin /media/sda5/Bodhi/e17_debs/$1/everything-pidgin_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/everything-pidgin_$1.tar.gz everything-pidgin_$1/

cd /media/sda5/Bodhi/e17_debs/$1/everything-pidgin_$1
dh_make -p everything-pidgin_$1 -e jeffhoogland@linux.com -f ../everything-pidgin_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/everything-pidgin/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../everything-pidgin*.deb
