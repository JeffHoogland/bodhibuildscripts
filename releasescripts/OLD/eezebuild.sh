#!/bin/sh

cd /home/jeff/$2/eeze-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/eeze-$2 /media/sda5/Bodhi/e17_debs/$1/eeze-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/eeze-$1.tar.gz eeze-$1/

cd /media/sda5/Bodhi/e17_debs/$1/eeze-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../eeze-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/eeze/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../eeze*.deb
