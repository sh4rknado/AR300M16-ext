#!/bin/bash
#current_folder="$(pwd)"

# clean all old files
rm ./tmp -rf
rm -rfv openwrt-imagebuilder
#git clean -xfd

# Making files
./scripts/feeds update -a
./scripts/feeds install -a

cp scripts/configurations .config
make V=s -j5

# update image builder
cd bin/targets/ar71xx/generic/
tar xvf openwrt-imagebuilder-ar71xx-generic.Linux-x86_64.tar.xz
mv openwrt-imagebuilder-ar71xx-generic.Linux-x86_64 ~/AR300M16-ext/openwrt-imagebuilder
rm -rfv openwrt-imagebuilder-ar71xx-generic.Linux-x86_64/

# copy builder
cp -avr overlay ~/AR300M16-ext/openwrt-imagebuilder/overlay/
mv ~/AR300M16-ext/openwrt-imagebuilder/overlay/build.sh ~/AR300M16-ext/openwrt-imagebuilder/build.sh
mv ~/AR300M16-ext/openwrt-imagebuilder/overlay/repositories.conf ~/AR300M16-ext/openwrt-imagebuilder/repositories.conf
