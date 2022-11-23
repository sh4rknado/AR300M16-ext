#!/bin/bash
current_folder=$(pwd)

# clean all old files
rm ./tmp -rf
#git clean -xfd

# Making files
./scripts/feeds update -a
./scripts/feeds install -a

cp scripts/configurations .config
make V=s -j5

# update image builder
cd bin/targets/ar71xx/generic/
tar xvf openwrt-imagebuilder-ar71xx-generic.Linux-x86_64.tar.xz
cp -avr openwrt-imagebuilder-ar71xx-generic.Linux-x86_64/* $current_folder/openwrt-imagebuilder/
rm -rfv openwrt-imagebuilder-ar71xx-generic.Linux-x86_64*

