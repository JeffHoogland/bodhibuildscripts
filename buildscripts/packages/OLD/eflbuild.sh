#!/bin/sh

cd /home/jeff/e17_src/efl && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/efl /media/sda5/Bodhi/e17_debs/$1/efl-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/efl-$1.tar.gz efl-$1/

cd /media/sda5/Bodhi/e17_debs/$1/efl-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../efl-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/efl/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../efl*.deb
