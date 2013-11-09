#!/bin/sh

cd /home/jeff/$2/elementary-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/elementary-$2 /media/sda5/Bodhi/e17_debs/$1/elementary-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/elementary-$1.tar.gz elementary-$1/

cd /media/sda5/Bodhi/e17_debs/$1/elementary-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../elementary-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/elementary/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../elementary*.deb
