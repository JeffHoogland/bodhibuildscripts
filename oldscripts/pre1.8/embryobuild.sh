#!/bin/sh

cd /home/jeff/$2/embryo-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/embryo-$2 /media/sda5/Bodhi/e17_debs/$1/embryo-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/embryo-$1.tar.gz embryo-$1/

cd /media/sda5/Bodhi/e17_debs/$1/embryo-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../embryo-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/embryo/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../embryo*.deb
