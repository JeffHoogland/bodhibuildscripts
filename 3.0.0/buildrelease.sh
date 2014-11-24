#!/bin/bash
TODAY = `date “+%Y%m%d”`
./eflbuild.sh $TODAY 1.11.2
./evas-generic-loadersbuild.sh $TODAY 1.11.2
./emotion-generic-playersbuild.sh $TODAY 1.11.0
./elementarybuild.sh $TODAY 1.11.2
./python-eflbuild.sh $TODAY 1.11.0
./terminologybuild.sh $TODAY 0.6.1
./econnmanbuild.sh $TODAY 1.1
