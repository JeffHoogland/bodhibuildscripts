#!/bin/sh

cd /home/jeff/e17_src/eobj && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/eobj /media/sda5/Bodhi/e17_debs/$1/eobj-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/eobj-$1.tar.gz eobj-$1/

cd /media/sda5/Bodhi/e17_debs/$1/eobj-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../eobj-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/eobj/* debian/
dpkg-buildpackage -rfakeroot 
dpkg -i ../eobj*.deb
