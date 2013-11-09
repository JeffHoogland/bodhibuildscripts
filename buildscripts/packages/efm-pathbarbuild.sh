#!/bin/sh

cd /home/jeff/e17_src/ && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/efm_pathbar /media/sda5/Bodhi/e17_debs/$1/efm-pathbar_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/efm-pathbar_$1.tar.gz efm-pathbar_$1/

cd /media/sda5/Bodhi/e17_debs/$1/efm-pathbar_$1
dh_make -p efm-pathbar_$1 -e jeffhoogland@linux.com -f ../efm-pathbar_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/efm-pathbar/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../efm-pathbar*.deb
