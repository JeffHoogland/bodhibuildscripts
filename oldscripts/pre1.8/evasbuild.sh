#!/bin/sh

cd /home/jeff/$2/evas-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/evas-$2 /media/sda5/Bodhi/e17_debs/$1/evas-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/evas-$1.tar.gz evas-$1/

cd /media/sda5/Bodhi/e17_debs/$1/evas-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../evas-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/evas/* debian/
#cp /media/sda5/Bodhi/e17_debs/rulefiles/evas/rules debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../evas*.deb
