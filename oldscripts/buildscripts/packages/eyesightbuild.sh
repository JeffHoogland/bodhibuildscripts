#!/bin/sh

cd /home/jeff/e17_src/eyesight && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/eyesight /media/sda5/Bodhi/e17_debs/$1/eyesight_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/eyesight_$1.tar.gz eyesight_$1/

cd /media/sda5/Bodhi/e17_debs/$1/eyesight_$1
dh_make -p eyesight_$1 -e jeffhoogland@linux.com -f ../eyesight_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/eyesight/* debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../eyesight*.deb
