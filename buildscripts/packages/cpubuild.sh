#!/bin/sh

cd /home/jeff/e17_src/cpu && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/cpu /media/sda5/Bodhi/e17_debs/$1/cpu-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/cpu-$1.tar.gz cpu-$1/

cd /media/sda5/Bodhi/e17_debs/$1/cpu-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../cpu-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/cpu/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../cpu*.deb
