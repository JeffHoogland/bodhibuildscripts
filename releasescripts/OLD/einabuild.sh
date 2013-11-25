#!/bin/sh

cd /home/jeff/$2/eina-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/eina-$2 /media/sda5/Bodhi/e17_debs/$1/eina-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/eina-$1.tar.gz eina-$1/

cd /media/sda5/Bodhi/e17_debs/$1/eina-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../eina-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/eina/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../eina*.deb
