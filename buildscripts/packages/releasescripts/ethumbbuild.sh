#!/bin/sh

cd /home/jeff/$2/ethumb-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/ethumb-$2 /media/sda5/Bodhi/e17_debs/$1/ethumb-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/ethumb-$1.tar.gz ethumb-$1/

cd /media/sda5/Bodhi/e17_debs/$1/ethumb-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../ethumb-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/ethumb/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../ethumb*.deb
