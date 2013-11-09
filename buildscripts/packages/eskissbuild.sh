#!/bin/sh

cd /home/jeff/e17_src/eskiss && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/eskiss /media/sda5/Bodhi/e17_debs/$1/eskiss-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/eskiss-$1.tar.gz eskiss-$1/

cd /media/sda5/Bodhi/e17_debs/$1/eskiss-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../eskiss-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/eskiss/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../eskiss*.deb
