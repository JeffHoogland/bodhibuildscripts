#!/bin/sh

cp -R ~/$2/e17-$2 /media/sda5/Bodhi/e17_debs/$1/e17-$1

cp /media/sda5/Bodhi/patches/e17/illume-keyboard/* /media/sda5/Bodhi/e17_debs/$1/e17-$1/src/modules/illume-keyboard/keyboards/

cd /media/sda5/Bodhi/e17_debs/$1/e17-$1
patch -p1 < /media/sda5/Bodhi/bodhibuildscripts/patches/bodhi_e17.diff

cd /media/sda5/Bodhi/e17_debs/$1
tar czvf e17-$1.tar.gz e17-$1/

cd /media/sda5/Bodhi/e17_debs/$1/e17-$1
make distclean
dh_make -e "Doug Yanez <deepspeed@bodhilinux.com>" -f ../e17-$1.tar.gz

cp -f /media/sda5/Bodhi/bodhibuildscripts/controlfiles/e17/* debian/
dpkg-buildpackage -rfakeroot -b
sudo dpkg -i ../e17*.deb
