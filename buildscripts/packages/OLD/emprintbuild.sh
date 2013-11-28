#!/bin/sh

cd /home/jeff/e17_src/emprint && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/emprint /media/sda5/Bodhi/e17_debs/$1/emprint-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/emprint-$1.tar.gz emprint-$1/

cd /media/sda5/Bodhi/e17_debs/$1/emprint-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../emprint-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/emprint/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../emprint*.deb
