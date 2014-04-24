#!/bin/sh

cd /home/jeff/e17_src/mail && make distclean
./autogen.sh
cp -R /home/jeff/e17_src/mail /media/sda5/Bodhi/e17_debs/$1/mail-$1
cd /media/sda5/Bodhi/e17_debs/$1
tar czvf /media/sda5/Bodhi/e17_debs/$1/mail-$1.tar.gz mail-$1/

cd /media/sda5/Bodhi/e17_debs/$1/mail-$1
make distclean
dh_make -e jeffhoogland@linux.com -f ../mail-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/mail/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../mail*.deb
