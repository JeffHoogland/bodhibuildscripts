#!/bin/sh

cd /home/jeff/e17_src/trash && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/trash /media/sda5/Bodhi/e17_debs/$1/trash-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/trash-$1.tar.gz trash-$1/

cd /media/sda5/Bodhi/e17_debs/$1/trash-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../trash-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/trash/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../trash*.deb
