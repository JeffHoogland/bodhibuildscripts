#!/bin/sh

cd /home/jeff/e17_src/elfe && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/elfe /media/sda5/Bodhi/e17_debs/$1/elfe-$1
cp -f /media/sda5/Bodhi/patches/elfe/* /media/sda5/Bodhi/e17_debs/$1/elfe-$1/data/themes/default/images/
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/elfe-$1.tar.gz elfe-$1/

cd /media/sda5/Bodhi/e17_debs/$1/elfe-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../elfe-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/elfe/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../elfe*.deb
