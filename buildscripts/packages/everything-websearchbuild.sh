#!/bin/sh

cd /home/jeff/e17_src/everything-websearch && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/everything-websearch /media/sda5/Bodhi/e17_debs/$1/everything-websearch_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/everything-websearch_$1.tar.gz everything-websearch_$1/

cd /media/sda5/Bodhi/e17_debs/$1/everything-websearch_$1
dh_make -p everything-websearch_$1 -e jeffhoogland@linux.com -f ../everything-websearch_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/everything-websearch/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../everything-websearch*.deb
