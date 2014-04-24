#!/bin/sh

cp -R /home/jeff/$2/python-efl-$2 /media/sda5/Bodhi/e17_debs/$1/python-efl_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/python-efl_$1.tar.gz python-efl_$1/

cd /media/sda5/Bodhi/e17_debs/$1/python-efl_$1
dh_make -p python-efl_$1 -e jeffhoogland@linux.com -f ../python-efl_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/python-efl/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../python-efl*.deb

cp -R /home/jeff/$2/python-efl-$2 /media/sda5/Bodhi/e17_debs/$1/python-efl-dbg_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/python-efl-dbg_$1.tar.gz python-efl-dbg_$1/

cd /media/sda5/Bodhi/e17_debs/$1/python-efl-dbg_$1
dh_make -p python-efl-dbg_$1 -e jeffhoogland@linux.com -f ../python-efl-dbg_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/python-efl-dbg/* debian/
dpkg-buildpackage -rfakeroot -b
