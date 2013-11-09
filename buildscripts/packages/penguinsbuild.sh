#!/bin/sh

cd /home/jeff/e17_src/penguins && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/penguins /media/sda5/Bodhi/e17_debs/$1/penguins-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/penguins-$1.tar.gz penguins-$1/

cd /media/sda5/Bodhi/e17_debs/$1/penguins-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../penguins-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/penguins/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../penguins*.deb
