#!/bin/sh

cd /home/jeff/$2/python-evas-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/python-evas-$2 /media/sda5/Bodhi/e17_debs/$1/python-evas_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/python-evas_$1.tar.gz python-evas_$1/


cd /media/sda5/Bodhi/e17_debs/$1/python-evas_$1
dh_make -p python-evas_$1 -e jeffhoogland@linux.com -f ../python-evas_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/python-evas/* debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../python-evas*.deb
