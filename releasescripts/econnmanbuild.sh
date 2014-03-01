#!/bin/sh

cd /home/jeff/$2/econnman-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/econnman-$2 /media/sda5/Bodhi/e17_debs/$1/econnman-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/econnman-$1.tar.gz econnman-$1/


cd /media/sda5/Bodhi/e17_debs/$1/econnman-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../econnman-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/econnman/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../econnman*.deb
