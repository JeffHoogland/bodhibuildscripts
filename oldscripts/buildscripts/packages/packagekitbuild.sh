#!/bin/sh

cd /home/jeff/e17_src/packagekit && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/packagekit /media/sda5/Bodhi/e17_debs/$1/epackagekit-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/epackagekit-$1.tar.gz epackagekit-$1/

cd /media/sda5/Bodhi/e17_debs/$1/epackagekit-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../epackagekit-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/epackagekit/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../epackagekit*.deb
