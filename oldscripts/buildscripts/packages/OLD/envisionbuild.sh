#!/bin/sh

cd /home/jeff/e17_src/envision && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/envision /media/sda5/Bodhi/e17_debs/$1/envision-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/envision-$1.tar.gz envision-$1/

cd /media/sda5/Bodhi/e17_debs/$1/envision-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../envision-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/envision/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../envision*.deb
