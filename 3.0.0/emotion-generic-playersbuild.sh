#!/bin/sh

mkdir -p ../../bodhi_debs/$1

cd ../../$2/emotion_generic_players-$2 && make distclean
autoreconf
cp -R ../../$2/emotion_generic_players-$2 ../../bodhi_debs/$1/emotion-generic-players_$1
cd ../../bodhi_debs/$1
tar czvf ../../bodhi_debs/$1/emotion-generic-players_$1.tar.gz emotion-generic-players_$1/

cd ../../bodhi_debs/$1/emotion-generic-players_$1
dh_make -p emotion-generic-players_$1 -e "Jeff Hoogland" -f ../emotion-generic-players_$1.tar.gz

cp ../controlfiles/emotion-generic-players/* debian/
dpkg-buildpackage -rfakeroot
sudo dpkg -i ../emotion-generic-players*.deb
