#!/bin/sh

mkdir -p ../../bodhi_debs/$1

if test "$2" = "git"
then
    cd ../../$2/enlightenment
    ./autogen.sh

    cp -R ../../$2/enlightenment ../../bodhi_debs/$1/e19-$1
else
    cd ../../$2/enlightenment-$2
    autoreconf

    cp -R ../../$2/enlightenment-$2 ../../bodhi_debs/$1/e19-$1
fi

cd ../../bodhi_debs/$1/e19-$1
rm -rf src/modules/wizard
cp -a ../../../bodhibuildscripts/patches/wizard-e19 src/modules/wizard

rm src/modules/systray/e_mod_main.c
cp ../../../bodhibuildscripts/patches/e_mod_main-e19-systray.c src/modules/systray/e_mod_main.c

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
