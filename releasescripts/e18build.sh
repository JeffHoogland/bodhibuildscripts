#!/bin/sh

#Normal package
cp -R /home/jeff/$2/enlightenment-$2 /media/sda5/Bodhi/e17_debs/$1/e18-$1

cp /media/sda5/Bodhi/patches/e18/illume-keyboard/* /media/sda5/Bodhi/e17_debs/$1/e18-$1/src/modules/illume-keyboard/keyboards/

cd /media/sda5/Bodhi/e17_debs/$1/e18-$1/src/bin
patch < /media/sda5/Bodhi/patches/e18/e/bodhi_menu.diff
patch < /media/sda5/Bodhi/patches/e18/e/module-patch.diff

#cp -f /media/sda5/Bodhi/patches/e18/wizard/page_025.c /media/sda5/Bodhi/e17_debs/$1/e18-$1/src/modules/wizard/
cp -f /media/sda5/Bodhi/patches/e18/wizard/*.patch /media/sda5/Bodhi/e17_debs/$1/e18-$1/

cd /media/sda5/Bodhi/e17_debs/$1/e18-$1
#patch -p1 < 0001-Fix-wizard-makefile.patch
#patch -p1 < 0002-Update-bodhi-wizard-code-to-build-again.patch

cd /media/sda5/Bodhi/e17_debs/$1
tar czvf e18-$1.tar.gz e18-$1/

cd /media/sda5/Bodhi/e17_debs/$1/e18-$1
autoreconf
make distclean
dh_make -e jeffhoogland@linux.com -f ../e18-$1.tar.gz

cp -f /media/sda5/Bodhi/e17_debs/controlfiles/e18/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../e18*.deb

#Debug package
#cp -R /home/jeff/$2/enlightenment-$2 /media/sda5/Bodhi/e17_debs/$1/e18-dbg_$1

#cp /media/sda5/Bodhi/patches/e18/illume-keyboard/* /media/sda5/Bodhi/e17_debs/$1/e18-dbg_$1/src/modules/illume-keyboard/keyboards/

#cd /media/sda5/Bodhi/e17_debs/$1/e18-dbg_$1/src/bin
#patch < /media/sda5/Bodhi/patches/e18/e/bodhi_menu.diff
#patch < /media/sda5/Bodhi/patches/e18/e/module-patch.diff

#cd /media/sda5/Bodhi/e17_debs/$1
#tar czvf e18-dbg_$1.tar.gz e18-dbg_$1/

#cd /media/sda5/Bodhi/e17_debs/$1/e18-dbg_$1
#make distclean
#dh_make -p e18-dbg_$1 -e jeffhoogland@linux.com -f ../e18-dbg_$1.tar.gz

#cp -f /media/sda5/Bodhi/e17_debs/controlfiles/e18-dbg/* debian/
#dpkg-buildpackage -rfakeroot -b
