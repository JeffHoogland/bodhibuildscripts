#!/bin/sh

#cd ~/$2/e17-$2 && make clean
#./configure
cp -R ~/$2/e17-$2 /media/sda5/Bodhi/e17_debs/$1/e17-$1

#cd /media/sda5/Bodhi/e17_debs/$1/e17-$1/src/modules
#rm Makefile.in
#rm Makefile_wizard.am
#rm -rf wizard
#cp -a /media/sda5/Bodhi/patches/e17/wizard/* .


cp /media/sda5/Bodhi/patches/e17/illume-keyboard/* /media/sda5/Bodhi/e17_debs/$1/e17-$1/src/modules/illume-keyboard/keyboards/

cd /media/sda5/Bodhi/e17_debs/$1/e17-$1/src/bin
#patch < /media/sda5/Bodhi/patches/e17/e/bodhi_menu.diff
#patch < /media/sda5/Bodhi/patches/e17/e/module-patch.diff
#patch -p0 < /media/sda5/Bodhi/patches/e/e_config.c.patch

cd /media/sda5/Bodhi/e17_debs/$1
tar czvf e17-$1.tar.gz e17-$1/


cd /media/sda5/Bodhi/e17_debs/$1/e17-$1
make distclean
dh_make -e "Doug Yanez <deepspeed@bodhilinux.com>" -f ../e17-$1.tar.gz

cp -f /media/sda5/Bodhi/bodhibuildscripts/controlfiles/e17/* debian/
dpkg-buildpackage -rfakeroot -b
sudo dpkg -i ../e17*.deb
