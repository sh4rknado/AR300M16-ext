#!/bin/bash

make image \
     PROFILE="gl-ar300m" \
     FILES="overlay" \
     PACKAGES="nano kmod-usb-net usbutils kmod-usb-core kmod-usb-storage kmod-rtl8812au-ac python-logging python-openssl python-sqlite3 python-codecs"

cp -avr bin/targets/ar71xx/generic/openwrt-ar71xx-generic-gl-ar300m-squashfs-sysupgrade.bin ~/gl-ar300m-squashfs-sysupgrade.bin

