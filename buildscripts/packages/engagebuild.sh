#!/bin/sh

cd /home/jeff/e17_src/engage && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/engage /media/sda5/Bodhi/e17_debs/$1/engage_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/engage_$1.tar.gz engage_$1/

cd /media/sda5/Bodhi/e17_debs/$1/engage_$1
dh_make -p engage_$1 -e jeffhoogland@linux.com -f ../engage_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/engage/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../engage*.deb
