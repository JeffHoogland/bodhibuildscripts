#!/bin/sh

cd /home/jeff/e17_src/flame && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/flame /media/sda5/Bodhi/e17_debs/$1/flame-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/flame-$1.tar.gz flame-$1/

cd /media/sda5/Bodhi/e17_debs/$1/flame-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../flame-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/flame/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../flame*.deb
