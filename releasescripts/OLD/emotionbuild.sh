#!/bin/sh

cd /home/jeff/$2/emotion-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/emotion-$2 /media/sda5/Bodhi/e17_debs/$1/emotion-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/emotion-$1.tar.gz emotion-$1/

cd /media/sda5/Bodhi/e17_debs/$1/emotion-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../emotion-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/emotion/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../emotion*.deb
