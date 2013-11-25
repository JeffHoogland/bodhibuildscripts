#!/bin/sh

cd /home/jeff/$2/eio-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/eio-$2 /media/sda5/Bodhi/e17_debs/$1/eio-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/eio-$1.tar.gz eio-$1/

cd /media/sda5/Bodhi/e17_debs/$1/eio-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../eio-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/eio/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../eio*.deb
