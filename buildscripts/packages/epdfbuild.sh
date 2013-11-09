#!/bin/sh

cd /home/jeff/e17_src/epdf && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/epdf /media/sda5/Bodhi/e17_debs/$1/epdf_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/epdf_$1.tar.gz epdf_$1/

cd /media/sda5/Bodhi/e17_debs/$1/epdf_$1
dh_make -p epdf_$1 -e jeffhoogland@linux.com -f ../epdf_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/epdf/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../epdf*.deb
