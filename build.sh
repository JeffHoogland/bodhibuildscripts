#!/bin/bash
# build script for terminology - https://www.enlightenment.org/docs-efl-start

# Debug tools
# sudo apt-get install gdb valgrind perf

# install build tools
sudo apt-get install -y git autoconf automake autopoint libtool gettext pkg-config curl dh-make doxygen fakeroot dialog fish
# these dependencies must be installed separately due to conflicts
sudo apt-get install -y libdbus-1-dev udev dbus
# now install the rest of the dependencies
sudo apt-get install -y libssl-dev libjpeg-dev libtiff4-dev libxpm-dev libgif-dev libwebp-dev libraw-dev librsvg2-dev libglu1-mesa-dev libsdl2-dev libluajit-5.1-dev libfreetype6-dev libfontconfig-dev libpoppler-dev libfribidi-dev libx11-dev  libxcursor-dev libxrender-dev libxrandr-dev libxfixes-dev libxdamage-dev libxcomposite-dev libxss-dev libxp-dev libxext-dev libxinerama-dev libxft-dev libxfont-dev libxi-dev libxv-dev libxkbfile-dev libxres-dev libxtst-dev libx11-xcb-dev libxcb-shape0-dev libxcb-image0-dev libxcb-keysyms1-dev xserver-xephyr libasound-dev libdbus-1-dev libltdl7-dev libxml2-dev libpam0g-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev libgstreamer-plugins-bad1.0-dev libpulse-dev libsndfile-dev libudev-dev libmount-dev libblkid-dev libbullet-dev libgnutls-dev libcurl4-gnutls-dev libc-ares-dev libharfbuzz-dev libspectre-dev libvlc-dev util-linux dbus-x11 alsa pulseaudio python-all-dev python-pillow python-pyrex python-dbus python-dbus-dev uuid-runtime

# Ensure default prefix /usr/local
export PATH=/usr/local/bin:"$PATH"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:"$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH=/usr/local/lib:"$LD_LIBRARY_PATH"


# Choose CFLAG (Replace march-native for older ARCH than build PC)
# CFLAG examples
# Optimised but debuggable   $>-02 -ffast-math -march-native -g -ggdb3
# Really debuggable	     $>-0 -g -ffast-math -march-native -ggcb3
export CFLAGS="-0.3 -ffast-math -march-native"

# Build Order
# requirements
# efl (>= 1.8.0)
# elementary (>= 1.8.0)
# terminology

# Note: to make terminology work with input methods in general you need:
#
export ECORE_IMF_MODULE="xim"
export XMODIFIERS="@im=none"
