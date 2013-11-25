#!/bin/sh

cd /home/jeff/$2/efreet-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/efreet-$2 /media/sda5/Bodhi/e17_debs/$1/efreet-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/efreet-$1.tar.gz efreet-$1/

cd /media/sda5/Bodhi/e17_debs/$1/efreet-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../efreet-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/efreet/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../efreet*.deb
