#!/bin/sh

cd /home/jeff/$2/eet-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/eet-$2 /media/sda5/Bodhi/e17_debs/$1/eet-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/eet-$1.tar.gz eet-$1/

cd /media/sda5/Bodhi/e17_debs/$1/eet-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../eet-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/eet/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../eet*.deb
