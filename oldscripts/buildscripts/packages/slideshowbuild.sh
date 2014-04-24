#!/bin/sh

cd /home/jeff/e17_src/slideshow && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/slideshow /media/sda5/Bodhi/e17_debs/$1/slideshow-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/slideshow-$1.tar.gz slideshow-$1/

cd /media/sda5/Bodhi/e17_debs/$1/slideshow-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../slideshow-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/slideshow/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../slideshow*.deb
