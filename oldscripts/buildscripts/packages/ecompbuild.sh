#!/bin/sh

cd /home/jeff/e17_src/ecomp && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/ecomp /media/sda5/Bodhi/e17_debs/$1/ecomp-$1
cd /media/sda5/Bodhi/e17_debs/$1
cp /media/sda5/Bodhi/e17_debs/controlfiles/ecomp/control /media/sda5/Bodhi/e17_debs/$1/ecomp-$1/debian/
tar czvf /media/sda5/Bodhi/e17_debs/$1/ecomp-$1.tar.gz ecomp-$1/

cd /media/sda5/Bodhi/e17_debs/$1/ecomp-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../ecomp-$1.tar.gz

dpkg-buildpackage -rfakeroot
dpkg -i ../ecomp*.deb
