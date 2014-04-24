#!/bin/sh

cd /home/jeff/$2/ecore-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/ecore-$2 /media/sda5/Bodhi/e17_debs/$1/ecore-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/ecore-$1.tar.gz ecore-$1/

cd /media/sda5/Bodhi/e17_debs/$1/ecore-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../ecore-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/ecore/* debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../ecore*.deb
