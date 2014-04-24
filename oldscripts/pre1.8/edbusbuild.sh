#!/bin/sh

cd /home/jeff/$2/e_dbus-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/e_dbus-$2 /media/sda5/Bodhi/e17_debs/$1/edbus-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/edbus-$1.tar.gz edbus-$1/

cd /media/sda5/Bodhi/e17_debs/$1/edbus-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../edbus-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/edbus/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../edbus*.deb
