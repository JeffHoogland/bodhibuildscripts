#!/bin/sh

cd ~/$2/evas_generic_loaders-$2 && make distclean
./autogen.sh
cp -R ~/$2/evas_generic_loaders-$2 /media/sda5/Bodhi/e17_debs/$1/evas-generic-loaders_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/evas-generic-loaders_$1.tar.gz evas-generic-loaders_$1/

cd /media/sda5/Bodhi/e17_debs/$1/evas-generic-loaders_$1
dh_make -p evas-generic-loaders_$1 -e jeffhoogland@linux.com -f ../evas-generic-loaders_$1.tar.gz

cp /media/sda5/Bodhi/bodhibuildscripts/controlfiles/evas-generic-loaders/* debian/
dpkg-buildpackage -rfakeroot
sudo dpkg -i ../evas-generic-loaders*.deb
