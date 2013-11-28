#!/bin/sh

cd /home/jeff/e17_src/libeweather && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/libeweather /media/sda5/Bodhi/e17_debs/$1/libeweather-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/libeweather-$1.tar.gz libeweather-$1/

cd /media/sda5/Bodhi/e17_debs/$1/libeweather-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../libeweather-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/libeweather/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../libeweather*.deb
