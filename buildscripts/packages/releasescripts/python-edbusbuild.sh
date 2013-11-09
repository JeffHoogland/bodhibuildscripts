#!/bin/sh

cd /home/jeff/$2/python-e_dbus-$2 && make distclean
./autogen.sh
cp -R /home/jeff/$2/python-e_dbus-$2 /media/sda5/Bodhi/e17_debs/$1/python-edbus_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/python-edbus_$1.tar.gz python-edbus_$1/

cd /media/sda5/Bodhi/e17_debs/$1/python-edbus_$1
dh_make -p python-edbus_$1 -e jeffhoogland@linux.com -f ../python-edbus_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/python-edbus/* debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../python-edbus*.deb
