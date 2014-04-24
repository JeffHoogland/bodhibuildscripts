#!/bin/sh

cd packages

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
./rainbuild.sh $1
./slideshowbuild.sh $1
./snowbuild.sh $1
./taskbarbuild.sh $1
./tclockbuild.sh $1
