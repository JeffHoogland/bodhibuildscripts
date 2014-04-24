#!/bin/sh

cd /home/jeff/e17_src/enlil && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/enlil /media/sda5/Bodhi/e17_debs/$1/enlil-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/enlil-$1.tar.gz enlil-$1/

cd /media/sda5/Bodhi/e17_debs/$1/enlil-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../enlil-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/enlil/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../enlil*.deb
