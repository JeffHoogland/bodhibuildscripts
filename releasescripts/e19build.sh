#!/bin/sh

#Normal package
cp -R /home/jeff/$2/enlightenment-$2 /media/sda5/Bodhi/e17_debs/$1/e19-$1

cp /media/sda5/Bodhi/patches/e19/illume-keyboard/* /media/sda5/Bodhi/e17_debs/$1/e19-$1/src/modules/illume-keyboard/keyboards/

cd /media/sda5/Bodhi/e17_debs/$1/e19-$1/src/bin
patch < /media/sda5/Bodhi/patches/e/bodhi_menu.diff
patch < /media/sda5/Bodhi/patches/e/module-patch.diff

cp -f /media/sda5/Bodhi/patches/e19/wizard/*.patch /media/sda5/Bodhi/e17_debs/$1/e19-$1/

cd /media/sda5/Bodhi/e17_debs/$1
tar czvf e19-$1.tar.gz e19-$1/

cd /media/sda5/Bodhi/e17_debs/$1/e19-$1
autoreconf
make distclean
dh_make -e jeffhoogland@linux.com -f ../e19-$1.tar.gz

cp -f /media/sda5/Bodhi/e17_debs/controlfiles/e19/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../e19*.deb
