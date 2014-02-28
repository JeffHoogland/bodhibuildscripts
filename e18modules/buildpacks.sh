#!/bin/bash

./forecastsbuild.sh $1
./placesbuild.sh $1
./elfebuild.sh $1
./packagekitbuild.sh $1
