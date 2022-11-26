#!/bin/bash

make image \
     PROFILE="gl-ar300m" \
     FILES="overlay" \
     PACKAGES="iw at autossh base-files bash block-mount ca-certificates chat dnsmasq e2fsprogs ethtool firewall hostapd-utils ip6tables iwinfo kmod-crypto-manager kmod-fs-ext4 kmod-fs-nfs kmod-fs-vfat kmod-gpio-button-hotplug kmod-ipt-offload kmod-leds-gpio kmod-ledtrig-default-on kmod-ledtrig-netdev kmod-ledtrig-timer kmod-mt76x2u kmod-nf-nathelper kmod-rt2800-usb kmod-rtl8187 kmod-scsi-generic kmod-usb-ohci kmod-usb-storage-extras kmod-usb-uhci kmod-usb2 libbz2-1.0 libcurl4 libelf1 libffi libgdbm libgmp10 libiconv-full2 libltdl7 libnet-1.2.x libnl200 libustream-mbedtls20150806 libxml2 logd macchanger mtd nano ncat netcat nginx openssh-client openssh-server openssh-sftp-server openssl-util php7-cgi php7-fpm php7-mod-hash php7-mod-json php7-mod-mbstring php7-mod-openssl php7-mod-session php7-mod-sockets php7-mod-sqlite3 ppp ppp-mod-pppoe procps-ng-pkill procps-ng-ps python-logging python-openssl python-sqlite3 ssmtp tcpdump-mini uci uclibcxx uclient-fetch urandom-seed urngd usb-modeswitch usbreset usbutils wget wireless-tools wpad busybox libatomic1 libstdcpp6 -wpad-basic -dropbear -odhcp6c -odhcpd-ipv6only"

cp -avr bin/targets/ar71xx/generic/openwrt-ar71xx-generic-gl-ar300m-squashfs-sysupgrade.bin ~/gl-ar300m-squashfs-sysupgrade.bin

