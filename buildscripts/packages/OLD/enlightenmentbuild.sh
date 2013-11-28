#!/bin/sh

cd /home/jeff/e17_src/e && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/e /media/sda5/Bodhi/e17_debs/$1/enlightenment-$1

cd /media/sda5/Bodhi/e17_debs/$1/enlightenment-$1/src/modules
rm -rf wizard
rm Makefile
rm Makefile_wizard.am
cp -a /media/sda5/Bodhi/patches/wizard/* .

cp /media/sda5/Bodhi/patches/illume-keyboard/* /media/sda5/Bodhi/e17_debs/$1/enlightenment-$1/src/modules/illume-keyboard/keyboards/

cd /media/sda5/Bodhi/e17_debs/$1/enlightenment-$1/src/bin
patch < /media/sda5/Bodhi/patches/e/bodhi_menu.diff
patch < /media/sda5/Bodhi/patches/e/module-patch.diff
patch -p0 < /media/sda5/Bodhi/patches/e/e_config.c.patch

cd /media/sda5/Bodhi/e17_debs/$1
tar czvf enlightenment-$1.tar.gz enlightenment-$1/


cd /media/sda5/Bodhi/e17_debs/$1/enlightenment-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../enlightenment-$1.tar.gz

cp -f /media/sda5/Bodhi/e17_debs/controlfiles/enlightenment/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../enlightenment*.deb
