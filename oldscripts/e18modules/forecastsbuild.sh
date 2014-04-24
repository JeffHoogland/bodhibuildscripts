#!/bin/sh

cd /home/jeff/e17_src/forecasts && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/forecasts /media/sda5/Bodhi/e17_debs/$1/forecasts-e18_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/forecasts-e18_$1.tar.gz forecasts-e18_$1/

cd /media/sda5/Bodhi/e17_debs/$1/forecasts-e18_$1
make distclean
dh_make -p forecasts-e18_$1 -e jeffhoogland@linux.com -f ../forecasts-e18_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/forecasts-e18/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../forecasts*.deb
