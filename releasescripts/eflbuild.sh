#!/bin/sh

cd /home/jeff/$2/efl-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/efl-$2 /media/sda5/Bodhi/e17_debs/$1/efl-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/efl-$1.tar.gz efl-$1/

cd /media/sda5/Bodhi/e17_debs/$1/efl-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../efl-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/efl/* debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../efl*.deb
