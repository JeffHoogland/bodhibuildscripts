#!/bin/sh

cd /home/jeff/e17_src/ecomorph && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/ecomorph /media/sda5/Bodhi/e17_debs/$1/ecomorph-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/ecomorph-$1.tar.gz ecomorph-$1/

cd /media/sda5/Bodhi/e17_debs/$1/ecomorph-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../ecomorph-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/ecomorph/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../ecomorph*.deb
