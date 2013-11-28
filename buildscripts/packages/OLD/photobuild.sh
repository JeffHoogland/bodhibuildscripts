#!/bin/sh

cd /home/jeff/e17_src/photo && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/photo /media/sda5/Bodhi/e17_debs/$1/photo-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/photo-$1.tar.gz photo-$1/

cd /media/sda5/Bodhi/e17_debs/$1/photo-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../photo-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/photo/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../photo*.deb
