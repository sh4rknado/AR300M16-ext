#!/bin/bash

make image \
     PROFILE="gl-ar300m" \
     FILES="overlay" \
     PACKAGES="nano kmod-usb-net usbutils kmod-usb-core kmod-usb-storage kmod-usb3 kmod-rtl8812au-ac python-logging python-openssl python-sqlite3 python-codecs"
