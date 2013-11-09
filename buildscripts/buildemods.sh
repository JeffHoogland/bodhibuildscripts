#!/bin/sh

mkdir /media/sda5/Bodhi/e17_debs/$1
cd /media/sda5/Bodhi/e17_debs/buildscripts/packages

#Core E
#./eflbuild.sh $1
#./ephysicsbuild.sh $1
#./edjebuild.sh $1
#./edbus2build.sh $1
#./efreetbuild.sh $1
#./edbusbuild.sh $1
#./eezebuild.sh $1

#Extras Deps
#./emotionbuild.sh $1
#./ethumbbuild.sh $1
#./epdfbuild.sh $1
#./elementarybuild.sh $1
#./enlightenmentbuild.sh $1

#EFL Apps
#./editjebuild.sh $1
#./elsabuild.sh $1
#./ephotobuild.sh $1
#./eskissbuild.sh $1
#./shotgunbuild.sh $1
#./envisionbuild.sh $1
#./enjoybuild.sh $1
#./terminologybuild.sh $1

#Ecomorph
#./ecompbuild.sh $1
#./ecomorphbuild.sh $1

#Extra Modules
./bodhi-closebuild.sh $1
./bodhi-shutdownbuild.sh $1
./cpubuild.sh $1
./comp-scalebuild.sh $1
./deskshowbuild.sh $1
./diskiobuild.sh $1
./elfebuild.sh $1
./everything-mprisbuild.sh $1
./everything-pidginbuild.sh $1
./everything-placesbuild.sh $1
./everything-trackerbuild.sh $1
./everything-wallpaperbuild.sh $1
./everything-websearchbuild.sh $1
./flamebuild.sh $1
./forecastsbuild.sh $1
./engagebuild.sh $1
./itaskbuild.sh $1
./mailbuild.sh $1
./membuild.sh $1
./moonbuild.sh $1
./netbuild.sh $1
./newsbuild.sh $1
./photobuild.sh $1
./placesbuild.sh $1
#./python-evasbuild.sh $1
#./python-ecorebuild.sh $1
#./python-edjebuild.sh $1
#./python-edbusbuild.sh $1
#./python-emotionbuild.sh $1
#./python-ethumbbuild.sh $1
#./python-elementarybuild.sh $1
./rainbuild.sh $1
#./screenshotbuild.sh $1
./slideshowbuild.sh $1
./snowbuild.sh $1
./taskbarbuild.sh $1
./tclockbuild.sh $1
