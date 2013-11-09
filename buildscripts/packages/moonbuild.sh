#!/bin/sh

cd /home/jeff/e17_src/moon && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/moon /media/sda5/Bodhi/e17_debs/$1/moon-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/moon-$1.tar.gz moon-$1/

cd /media/sda5/Bodhi/e17_debs/$1/moon-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../moon-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/moon/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../moon*.deb
