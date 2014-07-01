#!/bin/sh

#cd /home/jeff/$2/enlightenment-$2 && make clean
#./configure
cp -R /home/jeff/$2/enlightenment-$2 /media/sda5/Bodhi/e17_debs/$1/enlightenment-$1

cd /media/sda5/Bodhi/e17_debs/$1/enlightenment-$1/src/modules
rm Makefile.in
rm Makefile_wizard.am
rm -rf wizard
cp -a /media/sda5/Bodhi/patches/e17/wizard/* .


cp /media/sda5/Bodhi/patches/e17/illume-keyboard/* /media/sda5/Bodhi/e17_debs/$1/enlightenment-$1/src/modules/illume-keyboard/keyboards/

cd /media/sda5/Bodhi/e17_debs/$1/enlightenment-$1/src/bin
patch < /media/sda5/Bodhi/patches/e17/e/bodhi_menu.diff
patch < /media/sda5/Bodhi/patches/e17/e/module-patch.diff
#patch -p0 < /media/sda5/Bodhi/patches/e/e_config.c.patch

cd /media/sda5/Bodhi/e17_debs/$1
tar czvf enlightenment-$1.tar.gz enlightenment-$1/


cd /media/sda5/Bodhi/e17_debs/$1/enlightenment-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../enlightenment-$1.tar.gz

cp -f /media/sda5/Bodhi/bodhibuildscripts/controlfiles/enlightenment/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../enlightenment*.deb
