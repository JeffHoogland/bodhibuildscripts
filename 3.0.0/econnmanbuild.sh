#!/bin/sh

cd ~/$2/econnman-$2 && make distclean
./autogen.sh
cp -R ~/$2/econnman-$2 /media/sda5/Bodhi/e17_debs/$1/econnman-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/econnman-$1.tar.gz econnman-$1/


cd /media/sda5/Bodhi/e17_debs/$1/econnman-$1
make distclean
dh_make -e "Eric W. Brown <feneric@bodhilinux.com>" -f ../econnman-$1.tar.gz

cp /media/sda5/Bodhi/bodhibuildscripts/controlfiles/econnman/control debian/
dpkg-buildpackage -rfakeroot
#sudo dpkg -i ../econnman*.deb
