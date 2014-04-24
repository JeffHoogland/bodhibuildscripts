#!/bin/sh

cd /home/jeff/$2/python-epdf-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/python-epdf-$2 /media/sda5/Bodhi/e17_debs/$1/python-epdf_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/python-epdf_$1.tar.gz python-epdf_$1/

cd /media/sda5/Bodhi/e17_debs/$1/python-epdf_$1
dh_make -p python-epdf_$1 -e jeffhoogland@linux.com -f ../python-epdf_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/python-epdf/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../python-epdf*.deb
