#!/bin/sh

cd /home/jeff/e17_src/net && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/net /media/sda5/Bodhi/e17_debs/$1/net-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/net-$1.tar.gz net-$1/

cd /media/sda5/Bodhi/e17_debs/$1/net-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../net-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/net/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../net*.deb
