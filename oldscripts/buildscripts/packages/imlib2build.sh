#!/bin/sh

cd /home/jeff/e17_src/imlib2 && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/imlib2 /media/sda5/Bodhi/e17_debs/$1/imlib2-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/imlib2-$1.tar.gz imlib2-$1/

cd /media/sda5/Bodhi/e17_debs/$1/imlib2-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../imlib2-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/imlib2/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../imlib2*.deb
