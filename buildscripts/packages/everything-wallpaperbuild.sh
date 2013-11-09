#!/bin/sh

cd /home/jeff/e17_src/everything-wallpaper && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/everything-wallpaper /media/sda5/Bodhi/e17_debs/$1/everything-wallpaper_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/everything-wallpaper_$1.tar.gz everything-wallpaper_$1/

cd /media/sda5/Bodhi/e17_debs/$1/everything-wallpaper_$1
dh_make -p everything-wallpaper_$1 -e jeffhoogland@linux.com -f ../everything-wallpaper_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/everything-wallpaper/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../everything-wallpaper*.deb
