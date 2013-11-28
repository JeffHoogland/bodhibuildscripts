#!/bin/sh

cd /home/jeff/e17_src/ecrire && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/ecrire /media/sda5/Bodhi/e17_debs/$1/ecrire-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/ecrire-$1.tar.gz ecrire-$1/


cd /media/sda5/Bodhi/e17_debs/$1/ecrire-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../ecrire-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/ecrire/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../ecrire*.deb
