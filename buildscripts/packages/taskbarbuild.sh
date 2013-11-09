#!/bin/sh

cd /home/jeff/e17_src/taskbar && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/taskbar /media/sda5/Bodhi/e17_debs/$1/taskbar-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/taskbar-$1.tar.gz taskbar-$1/

cd /media/sda5/Bodhi/e17_debs/$1/taskbar-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../taskbar-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/taskbar/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../taskbar*.deb
