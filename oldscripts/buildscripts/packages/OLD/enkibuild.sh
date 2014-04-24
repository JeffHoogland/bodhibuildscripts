#!/bin/sh

cd /home/jeff/e17_src/enki && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/enki /media/sda5/Bodhi/e17_debs/$1/enki-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/enki-$1.tar.gz enki-$1/

cd /media/sda5/Bodhi/e17_debs/$1/enki-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../enki-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/enki/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../enki*.deb
