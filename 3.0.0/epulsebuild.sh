#!/bin/sh

cp -R /home/jeff/git/epulse-git /media/sda5/Bodhi/e17_debs/$1/epulse-e19_$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/epulse-e19_$1.tar.gz epulse-e19_$1/

cd /media/sda5/Bodhi/e17_debs/$1/epulse-e19_$1
make distclean
dh_make -p epulse-e19_$1 -e jeffhoogland@linux.com -f ../epulse-e19_$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/epulse-e19/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../epulse-e19*.deb
