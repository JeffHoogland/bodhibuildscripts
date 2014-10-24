#!/bin/bash

EVERSION="0.17.6"

#rm -rf ~/enlightenment/
rm enlightenment_${EVERSION}-1_i386.deb || echo -e "\e[31mOld .deb file not removed!\e[0m"
#cp -R ~/e17/enlightenment/* ~/enlightenment

echo
cd ~/enlightenment

git clean -xdf || exit $?
git checkout . || exit $?
#patch -p1 < ~/buildscripts/bodhibuildscripts/patches/bodhi_e17.diff
patch -p1 < ~/bodhibuildscripts/patches/bodhi_e17.diff || exit $?

./autogen.sh --prefix=/usr || exit $?
make dist || exit $?
mv *.tar.* ..
dh_make -y -m -e deepspeed@bodhilinux.com -f ../enlightenment-${EVERSION}.tar.gz -p enlightenment_${EVERSION} || exit $?

#mkdir debian/ && cp -R ../Documents/debian/* debian/
cp -R ~/bodhibuildscripts/controlfiles/enlightenment/* debian/ || exit $?
#nano -w debian/control

dpkg-buildpackage -rfakeroot -b || exit $?
#sudo dpkg -i ../enlightenment*.deb || exit $?

echo -e "\e[33mEnlightenment built succesfully!\e[0m"
exit
