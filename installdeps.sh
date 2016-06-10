#!/bin/sh

# install build tools
apt-get install curl git dh-make pkg-config doxygen autoconf fakeroot dialog sudo fish vim
# these dependencies must be installed separately due to conflicts
apt-get install libdbus-1-dev udev dbus
# now install the rest of the dependencies
apt-get install libssl-dev libjpeg-dev libtiff5-dev libxpm-dev libgif-dev libwebp-dev libraw-dev librsvg2-dev libglu1-mesa-dev libsdl2-dev libluajit-5.1-dev libfreetype6-dev libfontconfig-dev libpoppler-dev libfribidi-dev libx11-dev  libxcursor-dev libxrender-dev libxrandr-dev libxfixes-dev libxdamage-dev libxcomposite-dev libxss-dev libxext-dev libxinerama-dev libxft-dev libxfont-dev libxi-dev libxv-dev libxkbfile-dev libxres-dev libxtst-dev libx11-xcb-dev libxcb-shape0-dev libxcb-image0-dev libxcb-keysyms1-dev xserver-xephyr libasound-dev libdbus-1-dev libltdl7-dev libxml2-dev libpam0g-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev libgstreamer-plugins-bad1.0-dev libpulse-dev libsndfile-dev libudev-dev libmount-dev libblkid-dev libbullet-dev libgnutls-dev libcurl4-gnutls-dev libc-ares-dev libharfbuzz-dev libspectre-dev libvlc-dev util-linux dbus-x11 alsa pulseaudio python-all-dev python-pillow python-pyrex python-dbus python-dbus-dev uuid-runtime autopoint
