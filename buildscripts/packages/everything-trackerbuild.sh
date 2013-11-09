#!/bin/sh

cd /home/jeff/e17_src/everything-tracker && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/everything-tracker /media/sda5/Bodhi/e17_debs/$1/everything-tracker_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/everything-tracker_$1.tar.gz everything-tracker_$1/

cd /media/sda5/Bodhi/e17_debs/$1/everything-tracker_$1
dh_make -p everything-tracker_$1 -e jeffhoogland@linux.com -f ../everything-tracker_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/everything-tracker/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../everything-tracker*.deb
