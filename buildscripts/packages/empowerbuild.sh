#!/bin/sh

cd /home/jeff/e17_src/empower && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/empower /media/sda5/Bodhi/e17_debs/$1/empower-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/empower-$1.tar.gz empower-$1/

cd /media/sda5/Bodhi/e17_debs/$1/empower-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../empower-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/empower/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../empower*.deb
