#!/bin/sh

cd /home/jeff/e17_src/bodhi-close && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/bodhi-close /media/sda5/Bodhi/e17_debs/$1/bodhi-close_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/bodhi-close_$1.tar.gz bodhi-close_$1/


cd /media/sda5/Bodhi/e17_debs/$1/bodhi-close_$1
dh_make -p bodhi-close_$1 -e jeffhoogland@linux.com -f ../bodhi-close_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/bodhi-close/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../bodhi-close*.deb
