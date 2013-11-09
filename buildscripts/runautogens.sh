#!/bin/sh
for emod in /home/jeff/e17_src/*; do cd $emod && ./autogen.sh && make distclean; done
