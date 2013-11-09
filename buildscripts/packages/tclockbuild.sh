#!/bin/sh

cd /home/jeff/e17_src/tclock && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/tclock /media/sda5/Bodhi/e17_debs/$1/tclock-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/tclock-$1.tar.gz tclock-$1/

cd /media/sda5/Bodhi/e17_debs/$1/tclock-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../tclock-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/tclock/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../tclock*.deb
