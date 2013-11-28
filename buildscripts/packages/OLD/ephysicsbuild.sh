#!/bin/sh

cd /home/jeff/e17_src/ephysics && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/ephysics /media/sda5/Bodhi/e17_debs/$1/ephysics-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/ephysics-$1.tar.gz ephysics-$1/

cd /media/sda5/Bodhi/e17_debs/$1/ephysics-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../ephysics-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/ephysics/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../ephysics*.deb
