#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cd ../../$2/enlightenment-$2
autoreconf

#Normal package
cp -R ../../$2/enlightenment-$2 ../../bodhi_debs/$1/e19-$1

rm -rf src/modules/wizard
cp -a ../../../bodhibuildscripts/patches/wizard-e19 src/modules/wizard

rm -rf src/bin/e_int_menus.c
cp ../../../bodhibuildscripts/patches/e_int_menus-e19.c src/bin/e_int_menus.c

#cd ../../bodhi_debs/$1/e19-$1
#patch -p1 < ../../../bodhibuildscripts/patches/bodhi_e19.diff

cd ..
tar czvf e19-$1.tar.gz e19-$1/

cd e19-$1
dh_make -e "Jeff Hoogland" -f ../e19-$1.tar.gz

cp -f ../../../bodhibuildscripts/controlfiles/e19/* debian/
dpkg-buildpackage -rfakeroot -b
sudo dpkg -i ../e19*.deb
