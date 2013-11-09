#!/bin/sh

cd /home/jeff/e17_src/screenshot && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/screenshot /media/sda5/Bodhi/e17_debs/$1/screenshot-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/screenshot-$1.tar.gz screenshot-$1/

cd /media/sda5/Bodhi/e17_debs/$1/screenshot-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../screenshot-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/screenshot/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../screenshot*.deb
