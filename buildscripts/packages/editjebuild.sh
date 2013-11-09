#!/bin/sh

cd /home/jeff/e17_src/editje && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/editje /media/sda5/Bodhi/e17_debs/$1/editje-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/editje-$1.tar.gz editje-$1/

cd /media/sda5/Bodhi/e17_debs/$1/editje-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../editje-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/editje/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../editje*.deb
