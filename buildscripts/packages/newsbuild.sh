#!/bin/sh

cd /home/jeff/e17_src/news && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/news /media/sda5/Bodhi/e17_debs/$1/news-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/news-$1.tar.gz news-$1/

cd /media/sda5/Bodhi/e17_debs/$1/news-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../news-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/news/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../news*.deb
