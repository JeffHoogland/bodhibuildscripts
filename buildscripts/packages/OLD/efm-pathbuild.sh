#!/bin/sh

cp -R /home/jeff/e17_src/efm_path /media/sda5/Bodhi/e17_debs/$1/efm-path_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/efm-path_$1.tar.gz efm-path_$1/


cd /media/sda5/Bodhi/e17_debs/$1/efm-path_$1
dh_make -p efm-path_$1 -e jeffhoogland@linux.com -f ../efm-path_$1.tar.gz
make distclean
./autogen.sh
cp /media/sda5/Bodhi/e17_debs/controlfiles/efm-path/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../efm-path*.deb
