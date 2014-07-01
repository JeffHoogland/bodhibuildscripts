#!/bin/sh

cp -R /home/jeff/$2/python-efl-$2 /media/sda5/Bodhi/e17_debs/$1/python-efl_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/python-efl_$1.tar.gz python-efl_$1/

cd /media/sda5/Bodhi/e17_debs/$1/python-efl_$1
dh_make -p python-efl_$1 -e jeffhoogland@linux.com -f ../python-efl_$1.tar.gz

cp /media/sda5/Bodhi/bodhibuildscripts/controlfiles/python-efl/* debian/
dpkg-buildpackage -rfakeroot -b
dpkg -i ../python-efl*.deb
