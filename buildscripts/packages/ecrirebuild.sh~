#!/bin/sh

cd /home/jeff/e17_src/ephoto && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/ephoto /media/sda5/Bodhi/e17_debs/$1/ephoto-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/ephoto-$1.tar.gz ephoto-$1/


cd /media/sda5/Bodhi/e17_debs/$1/ephoto-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../ephoto-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/ephoto/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../ephoto*.deb
