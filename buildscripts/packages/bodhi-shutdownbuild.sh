#!/bin/sh

cd /home/jeff/e17_src/bodhi-shutdown && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/bodhi-shutdown /media/sda5/Bodhi/e17_debs/$1/bodhi-shutdown_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/bodhi-shutdown_$1.tar.gz bodhi-shutdown_$1/


cd /media/sda5/Bodhi/e17_debs/$1/bodhi-shutdown_$1
dh_make -p bodhi-shutdown_$1 -e jeffhoogland@linux.com -f ../bodhi-shutdown_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/bodhi-shutdown/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../bodhi-shutdown*.deb
