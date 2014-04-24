#!/bin/sh

cp -R /home/jeff/$2/efl-$2 /media/sda5/Bodhi/e17_debs/$1/efl-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/efl-$1.tar.gz efl-$1/

cd /media/sda5/Bodhi/e17_debs/$1/efl-$1
dh_make -e jeffhoogland@linux.com -f ../efl-$1.tar.gz
make distclean
cp /media/sda5/Bodhi/e17_debs/controlfiles/efl/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../efl*.deb

#cp -R /home/jeff/$2/efl-$2 /media/sda5/Bodhi/e17_debs/$1/efl-dbg_$1
#cd /media/sda5/Bodhi/e17_debs/$1
#tar czvf /media/sda5/Bodhi/e17_debs/$1/efl-dbg_$1.tar.gz efl-dbg_$1/

#cd /media/sda5/Bodhi/e17_debs/$1/efl-dbg_$1
#dh_make -p efl-dbg_$1 -e jeffhoogland@linux.com -f ../efl-dbg_$1.tar.gz
#make distclean
#cp /media/sda5/Bodhi/e17_debs/controlfiles/efl-dbg/* debian/
#dpkg-buildpackage -rfakeroot -b
