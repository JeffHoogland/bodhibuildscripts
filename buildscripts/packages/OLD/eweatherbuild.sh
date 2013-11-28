#!/bin/sh

cd /home/jeff/e17_src/eweather && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/eweather /media/sda5/Bodhi/e17_debs/$1/eweather-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/eweather-$1.tar.gz eweather-$1/

cd /media/sda5/Bodhi/e17_debs/$1/eweather-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../eweather-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/eweather/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../eweather*.deb
