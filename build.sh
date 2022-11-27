#!/bin/bash
#current_folder="$(pwd)"

# clean all old files
bash clean.sh

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
cd  ~/AR300M16-ext/openwrt-imagebuilder/
cp -avr ../overlay .
mv overlay/build.sh build.sh
mv overlay/repositories.conf repositories.conf
