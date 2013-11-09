#!/bin/sh

cd /home/jeff/e17_src/tiling && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/tiling /media/sda5/Bodhi/e17_debs/$1/tiling-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/tiling-$1.tar.gz tiling-$1/

cd /media/sda5/Bodhi/e17_debs/$1/tiling-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../tiling-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/tiling/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../tiling*.deb
