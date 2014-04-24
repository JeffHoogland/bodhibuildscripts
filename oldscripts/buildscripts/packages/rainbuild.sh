#!/bin/sh

cd /home/jeff/e17_src/rain && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/rain /media/sda5/Bodhi/e17_debs/$1/rain-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/rain-$1.tar.gz rain-$1/

cd /media/sda5/Bodhi/e17_debs/$1/rain-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../rain-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/rain/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../rain*.deb
