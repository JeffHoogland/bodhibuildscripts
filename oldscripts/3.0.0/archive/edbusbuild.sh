#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cd ../../$2/e_dbus-$2 && make distclean
autoreconf
cp -R ../../$2/e_dbus-$2 ../../bodhi_debs/$1/edbus-$1
cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/edbus-$1.tar.gz edbus-$1/

cd ../../bodhi_debs/$1/edbus-$1
make distclean
dh_make -e "Jeff Hoogland <jeffhoogland@linux.com>" -f ../edbus-$1.tar.gz

cp /media/sda5/Bodhi/e17_debs/controlfiles/edbus/control debian/
dpkg-buildpackage -rfakeroot
dpkg -i ../edbus*.deb
