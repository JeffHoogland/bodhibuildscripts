#!/bin/sh

cd /home/jeff/e17_src/elsa && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/elsa /media/sda5/Bodhi/e17_debs/$1/elsa-$1
cp -f /media/sda5/Bodhi/patches/elsa/data/elsa /media/sda5/Bodhi/e17_debs/$1/elsa-$1/data/
#cp -f /media/sda5/Bodhi/patches/elsa/data/themes/beaumonts/* /media/sda5/Bodhi/e17_debs/$1/elsa-$1/data/themes/beaumonts/
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/elsa-$1.tar.gz elsa-$1/

cd /media/sda5/Bodhi/e17_debs/$1/elsa-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../elsa-$1.tar.gz

cp -f /media/sda5/Bodhi/e17_debs/controlfiles/elsa/* debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../elsa*.deb
