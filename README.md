# WiFi Pinneapple GLINET AR300M16-EXT 


RTL8812AU/21AU and RTL8814AU drivers
========


[![Monitor mode](https://img.shields.io/badge/monitor%20mode-working-brightgreen.svg)](#)
[![Frame Injection](https://img.shields.io/badge/frame%20injection-working-brightgreen.svg)](#)
[![GitHub version](https://raster.shields.io/badge/version-openwrt_19.0.7-lightgrey.svg)](#)
<br>
[![aircrack-ng](https://img.shields.io/badge/aircrack--ng-supported-blue.svg)](https://github.com/aircrack-ng/aircrack-ng)
[![wifite2](https://img.shields.io/badge/wifite2-supported-blue.svg)](https://github.com/kimocoder/wifite2)

Overview
========

This repo is maintained by GL.iNet team, which is used to release stock firmware.

Feature
=======

- Support latest device of GL.iNet
- Support kernel driver which isn't support by kernel-tree
- Keep updating with stock firmware

Branches Introduction
=======
- **openwrt-18.06-siflower** Only supports SF1200

- **openwrt-18.06-s1300** Support compiling openwrt firmware for S1300

    If you need to flash OpenWrt firmware on S1300, you need to modify the partition table using the intermediate firmware in this branch

- **openwrt-18.06** Compile versions before 3.105 firmware based on this source code

- **openwrt-18.06.5** Compile version 3.105 firmware based on this source code

- **openwrt-19.07.7** Compile version 3.201 firmware based on this source code

- **openwrt-19.07.8** Under development, not recommended

- **openwrt-trunk** Compile S1300 firmware supporting emmc

**For example, if you want to use openwrt-19.07.7 to compile the production firmware, you need to use *```git checkout openwrt-19.07.7```* command to switch openwrt-19.07.7 branch.**

Product Branch Relationship Table
=======
**Support Branch:** Branches that support this product

**Official OpenWrt :** Official OpenWrt supports this product from the current release
| Product | Support Branch | Official OpenWrt | Remark |
| :-----| :----- | :---- | :---- |
| AR150 | openwrt-18.06<br>openwrt-18.06.5<br>openwrt-19.07.7 | >17.01 |  |
| MIFI | openwrt-18.06<br>openwrt-18.06.5<br>openwrt-19.07.7 | >17.01 |  |
| AR300M | openwrt-18.06<br>openwrt-18.06.5<br>openwrt-19.07.7 | 17.01~19.07(nor)^<br>>21.02(nor+nand)^ | |
| MT300N-V2 | openwrt-18.06<br>openwrt-18.06.5<br>openwrt-19.07.7 | >18.06 | GL fireware wifi drivers are closed source, we do not guarantee that OpenWrt drivers are stable |
| B1300 | openwrt-18.06<br>openwrt-18.06.5<br>openwrt-19.07.7 | >18.06 | GL fireware use QSDK, if you use openwrt to compile firmware, there isn't mesh function|
| USB150 | openwrt-18.06<br>openwrt-18.06.5<br>openwrt-19.07.7 | >18.06 |  |
| AR750 | openwrt-18.06<br>openwrt-18.06.5<br>openwrt-19.07.7 | >18.06 |  |
| AR750S | openwrt-18.06<br>openwrt-18.06.5<br>openwrt-19.07.7 | 19.07(nor)^<br>>21.02(nor+nand)^ | |
| X750 | openwrt-18.06<br>openwrt-19.07.7 | >19.07 |  |
| S1300 | openwrt-19.07.7(nor)^<br>openwrt-trunk(emmc)^ | >21.02(nor)^ | |
| N300 | openwrt-18.06<br>openwrt-19.07.7 | >21.02 | GL fireware wifi drivers are closed source, we do not guarantee that OpenWrt drivers are stable |
| X1200 | openwrt-18.06<br>openwrt-19.07.7 | N | Must choose ath10k-firmware-qca9888-ct-htt and kmod-ath10k-ct packages |
| MV1000 | openwrt-19.07.7 | >21.02 |  |
| E750 | openwrt-18.06<br>openwrt-19.07.7 | >21.02 |  |
| AP1300 | We don't make patch for this project, so you must use the official OpenWrt | >21.02 |  |
| B2200 | openwrt-trunk(emmc) | >21.02 |  |
| MT1300 | openwrt-19.07.7 | >21.02 | GL fireware wifi drivers are closed source, we do not guarantee that OpenWrt drivers are stable |
| XE300 | openwrt-19.07.7 | N |  |
| X300B | openwrt-18.06.5<br>openwrt-19.07.7 | N |  |
| SF1200 |  |  |  |
| AX1800 |  |  |  |

^nor: Compiled firmware can only run on nor flash

^nor+nand: Can compile the firmware that runs on nor flash and nand flash

^nor+emmc: Can compile the firmware that runs on nor flash and emmc

Prerequisites
=============

To build your own firmware you need to have access to a Linux, BSD or MacOSX system (case-sensitive filesystem required). Cygwin will not be supported because of the lack of case sensitiveness in the file system. Ubuntu is usually recommended.

Installing Packages
-------------------

```bash
$ sudo apt-get update
$ sudo apt-get install build-essential subversion libncurses5-dev zlib1g-dev gawk gcc-multilib flex git-core gettext libssl-dev
```

Downloading Source
------------------

```
$ git clone https://github.com/gl-inet/openwrt.git openwrt
$ cd openwrt
```

Updating Feeds
--------------

```
$ ./scripts/feeds update -a
$ ./scripts/feeds install -a
```

Note that if you have all the source already, just put them in your *openwrt/dl* folder and you save time to download resource.

Clear temp buffer
-----------------

```
$ rm ./tmp -rf
```


Compile firmware for NOR flash
=======
Suitable for all products

Select target
-------------
Issueing **make menuconfig** to select a GL.iNet device, for example AR300M.

```
$ make menuconfig
```

Please select options as following:

	Target System (Atheros AR7xxx/AR9xxx)  --->

	Subtarget (Generic)  --->

	Target Profile (GL-AR300M)  --->

Then select common software package (as you need),such as USB driver as following,

    GL.iNet packages choice shortcut  --->

       [ ] Select basic packages
           Select VPN  --->
       [*] Support storage
       [*] Support USB
       [ ] Support webcam
       [ ] Support rtc

If the package you want to brush depends on the GL base package, please Select **Select basic packages** as well. Which packages the GL base package contains can be found in *config/config-glinet.in*

Compile
-------
Simply running **make V=s -j5** will build your own firmware. It will download all sources, build the cross-compile toolchain, the kernel and all choosen applications which is spent on several hours.

```
$ make V=s -j5
```


Notice **V=s**, this parameter is purpose to check info when compile.
**-j5**, this parameter is for choosing the cpu core number, 5 means using 4 cores.
If there’s error, please use **make V=s -j1** to recompile, and check the error.

Target file location for NOR flash
-----------------------------------
The final firmware file is **bin/ar71xx/openwrt-ar71xx-generic-gl-ar300m-squashfs-sysupgrade.bin**
so this file is the firmware we need, please update firmware again.
Please refer to other instructions for further operations. Such as flash the firmware, etc.


Compile firmware for NAND flash
=====
Applicable to GL-AR300M GL-AR750S GL-E750 GL-X1200 GL-X750

Select target
-------------
Issueing **make menuconfig** to select a GL.iNet device, for example AR300M.

```
$ make menuconfig
```

Please select options as following:

	Target System (Atheros AR7xxx/AR9xxx)  --->

	Subtarget (Generic devices with NAND flash)  --->

	Target Profile (GL-AR300M NAND)  --->

Then select common software package (as you need),such as USB driver as following,

    GL.iNet packages choice shortcut  --->

       [ ] Select basic packages
           Select VPN  --->
       [*] Support storage
       [*] Support USB
       [ ] Support webcam
       [ ] Support rtc

If the package you want to brush depends on the GL base package, please Select **Select basic packages** as well. Which packages the GL base package contains can be found in *config/config-glinet.in*

Compile
-------
Simply running **make V=s -j5** will build your own firmware. It will download all sources, build the cross-compile toolchain, the kernel and all choosen applications which is spent on several hours.

```
$ make V=s -j5
```

Notice **V=s**, this parameter is purpose to check info when compile.
**-j5**, this parameter is for choosing the cpu core number, 5 means using 4 cores.
If there’s error, please use **make V=s -j1** to recompile, and check the error.

Target file location for NAND flash
-----------------------------------

The final firmware file is:

**bin/ar71xx/openwrt-ar71xx-nand-gl-ar300m-rootfs-squashfs.ubi**

**bin/ar71xx/openwrt-ar71xx-nand-gl-ar300m-squashfs-sysupgrade.tar**

So this file is the firmware we need, please update firmware again.
Please refer to other instructions for further operations. Such as flash the firmware, etc.


# System Information




# System Preparation

## Make extroot 

source link : https://openwrt.org/docs/guide-user/additional-software/extroot_configuration

### install dependencies

    opkg update
    opkg install block-mount kmod-fs-ext4 e2fsprogs parted
    parted -s /dev/sda -- mklabel gpt mkpart extroot 2048s -2048s

### Configuring rootfs_data

    DEVICE="$(sed -n -e "/\s\/overlay\s.*$/s///p" /etc/mtab)"
    uci -q delete fstab.rwm
    uci set fstab.rwm="mount"
    uci set fstab.rwm.device="${DEVICE}"
    uci set fstab.rwm.target="/rwm"
    uci commit fstab

 Or, you can identify the rootfs_data partition manually, if it is in an MTD partition: 

    grep -e rootfs_data /proc/mtd

If your rootfs_data is a UBIFS volume, the above will not work. However, the sed command at the start of the section should pick up the correct device.

The /rwm mount will not mount via block until you've already successfully booted into your extroot configuration. This is because block has a restriction to only mount from devices that are not currently mounted. And /rwm should already be mounted at /overlay. Once booted into your extroot, you can edit /rwm/upper/etc/config/fstab to change your extroot configuration (or temporarily disable it) should you ever need to. 


  ### Configuring extroot

 See what partitions you have using the following command: 

     block info

 You will see similar output: 

    /dev/mtdblock2: UUID="9fd43c61-c3f2c38f-13440ce7-53f0d42d" VERSION="4.0" MOUNT="/rom" TYPE="squashfs"
    /dev/mtdblock3: MOUNT="/overlay" TYPE="jffs2"
    /dev/sda1: UUID="fdacc9f1-0e0e-45ab-acee-9cb9cc8d7d49" VERSION="1.4" TYPE="ext4"

Here mtdblock are the devices in internal flash memory, and /dev/sda1 is the partition on a USB flash drive that we have already formatted to ext4 like this: 

    DEVICE="/dev/sda1"
    mkfs.ext4 -L extroot ${DEVICE}

Now we configure the selected partition as new overlay via fstab UCI subsystem:

    eval $(block info ${DEVICE} | grep -o -e "UUID=\S*")
    uci -q delete fstab.overlay
    uci set fstab.overlay="mount"
    uci set fstab.overlay.uuid="${UUID}"
    uci set fstab.overlay.target="/overlay"
    uci commit fstab

### Transferring data

We now transfer the content of the current overlay to the external drive and reboot the device to apply changes:

    mount ${DEVICE} /mnt
    tar -C /overlay -cvf - . | tar -C /mnt -xf -
    reboot

### Testing

Web interface instructions

    LuCI → System → Mount Points should show USB partition mounted as overlay.
    LuCI → System → Software should show free space of overlay partition.

    grep -e /overlay /etc/mtab
    /dev/sda1 /overlay ext4 rw,relatime,data=ordered
    overlayfs:/overlay / overlay rw,noatime,lowerdir=/,upperdir=/overlay/upper,workdir=/overlay/work

    df overlay/
    Filesystem           1K-blocks      Used Available Use% Mounted on
    /dev/sda1              7759872    477328   7221104   6% /overlay
    overlayfs:/overlay     7759872    477328   7221104   6% /


## Swap
If your device fails to read the lists due to small RAM such as 32MB, enable swap.

### Create swap file
    dd if=/dev/zero of=/overlay/swap bs=1M count=100
    mkswap /overlay/swap

### Enable swap file
    uci -q delete fstab.swap
    uci set fstab.swap="swap"
    uci set fstab.swap.device="/overlay/swap"
    uci commit fstab
    /etc/init.d/fstab boot

### Verify swap status
    cat /proc/swaps


# Pineapple integration

### DNS Configuration

Add AAA record into the DNS resolution (complete file is in the overlay folder)

    config domain 'gl-admin'
          option name 'gl-admin.lan'
          option ip '192.168.8.1'

    config domain 'pineapple'
          option name 'pineapple.lan'
          option ip '192.168.8.1'

Restart the dnsmasq service 

    /etc/init.d/dnsmasq restart

Testing the resolution from dhcp

    nslookup pineapple.lan

    Server:         192.168.8.1
    Address:        192.168.8.1#53

    Name:   pineapple.lan
    Address: 192.168.8.1

    nslookup gl-admin.lan

    Server:         192.168.8.1
    Address:        192.168.8.1#53

    Name:   gl-admin.lan
    Address: 192.168.8.1

### Change location for separe webui

    mkdir /glinet-firmware
    cp -avr /www /glinet-firmware
    rm -rfv /www/*
    mv /glinet-firmware /www
    cp /www/glinet-firmware/api /www/api
    rm /www/glinet-firmware/api

### Update fast-cgi configuration

Remove the fast-cgi from general config (/etc/lighttpd/lighttpd.conf) and copy past the cgi config into /etc/lighttpd/conf.d/30-fastcgi.conf

        fastcgi.server = (
                "/api" => (
                        "api.handler" => (
                                "socket" => "/tmp/api.socket",
                                "check-local" => "disable",
                                "bin-path" => "/www/api",
                                "max-procs" => 1,
                                "allow-x-send-file" => "enable"
                            )
                         )
        )

### add the openwrt repository

        nano /etc/opkg/distfeeds.conf

        # Openwrt Package 19.07.9
        src/gz openwrt_core http://downloads.openwrt.org/releases/19.07.9/targets/ath79/generic/packages
        src/gz openwrt_kmods http://downloads.openwrt.org/releases/19.07.9/targets/ath79/generic/kmods/4.14.267-1>
        src/gz openwrt_base http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/base
        src/gz openwrt_freifunk http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/freifunk
        src/gz openwrt_luci http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/luci
        src/gz openwrt_packages http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/packages
        src/gz openwrt_routing http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/routing
        src/gz openwrt_telephony http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/telephony

        opkg update 

### Make VHOST in lighttpd

        opkg install lighttpd-mod-simple_vhost

        Installing lighttpd-mod-simple_vhost (1.4.55-1) to root...
        Downloading http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/packages/lighttpd-mod-simple_vhost_1.4.55-1_mips_24kc.ipk
        Configuring lighttpd-mod-simple_vhost.
# System Information




# System Preparation

## Make extroot 

source link : https://openwrt.org/docs/guide-user/additional-software/extroot_configuration

### install dependencies

    opkg update
    opkg install block-mount kmod-fs-ext4 e2fsprogs parted
    parted -s /dev/sda -- mklabel gpt mkpart extroot 2048s -2048s

### Configuring rootfs_data

    DEVICE="$(sed -n -e "/\s\/overlay\s.*$/s///p" /etc/mtab)"
    uci -q delete fstab.rwm
    uci set fstab.rwm="mount"
    uci set fstab.rwm.device="${DEVICE}"
    uci set fstab.rwm.target="/rwm"
    uci commit fstab

 Or, you can identify the rootfs_data partition manually, if it is in an MTD partition: 

    grep -e rootfs_data /proc/mtd

If your rootfs_data is a UBIFS volume, the above will not work. However, the sed command at the start of the section should pick up the correct device.

The /rwm mount will not mount via block until you've already successfully booted into your extroot configuration. This is because block has a restriction to only mount from devices that are not currently mounted. And /rwm should already be mounted at /overlay. Once booted into your extroot, you can edit /rwm/upper/etc/config/fstab to change your extroot configuration (or temporarily disable it) should you ever need to. 


  ### Configuring extroot

 See what partitions you have using the following command: 

     block info

 You will see similar output: 

    /dev/mtdblock2: UUID="9fd43c61-c3f2c38f-13440ce7-53f0d42d" VERSION="4.0" MOUNT="/rom" TYPE="squashfs"
    /dev/mtdblock3: MOUNT="/overlay" TYPE="jffs2"
    /dev/sda1: UUID="fdacc9f1-0e0e-45ab-acee-9cb9cc8d7d49" VERSION="1.4" TYPE="ext4"

Here mtdblock are the devices in internal flash memory, and /dev/sda1 is the partition on a USB flash drive that we have already formatted to ext4 like this: 

    DEVICE="/dev/sda1"
    mkfs.ext4 -L extroot ${DEVICE}

Now we configure the selected partition as new overlay via fstab UCI subsystem:

    eval $(block info ${DEVICE} | grep -o -e "UUID=\S*")
    uci -q delete fstab.overlay
    uci set fstab.overlay="mount"
    uci set fstab.overlay.uuid="${UUID}"
    uci set fstab.overlay.target="/overlay"
    uci commit fstab

### Transferring data

We now transfer the content of the current overlay to the external drive and reboot the device to apply changes:

    mount ${DEVICE} /mnt
    tar -C /overlay -cvf - . | tar -C /mnt -xf -
    reboot

### Testing

Web interface instructions

    LuCI → System → Mount Points should show USB partition mounted as overlay.
    LuCI → System → Software should show free space of overlay partition.

    grep -e /overlay /etc/mtab
    /dev/sda1 /overlay ext4 rw,relatime,data=ordered
    overlayfs:/overlay / overlay rw,noatime,lowerdir=/,upperdir=/overlay/upper,workdir=/overlay/work

    df overlay/
    Filesystem           1K-blocks      Used Available Use% Mounted on
    /dev/sda1              7759872    477328   7221104   6% /overlay
    overlayfs:/overlay     7759872    477328   7221104   6% /


## Swap
If your device fails to read the lists due to small RAM such as 32MB, enable swap.

### Create swap file
    dd if=/dev/zero of=/overlay/swap bs=1M count=100
    mkswap /overlay/swap

### Enable swap file
    uci -q delete fstab.swap
    uci set fstab.swap="swap"
    uci set fstab.swap.device="/overlay/swap"
    uci commit fstab
    /etc/init.d/fstab boot

### Verify swap status
    cat /proc/swaps


# Pineapple integration

### DNS Configuration

Add AAA record into the DNS resolution (complete file is in the overlay folder)

    config domain 'gl-admin'
          option name 'gl-admin.lan'
          option ip '192.168.8.1'

    config domain 'pineapple'
          option name 'pineapple.lan'
          option ip '192.168.8.1'

Restart the dnsmasq service 

    /etc/init.d/dnsmasq restart

Testing the resolution from dhcp

    nslookup pineapple.lan

    Server:         192.168.8.1
    Address:        192.168.8.1#53

    Name:   pineapple.lan
    Address: 192.168.8.1

    nslookup gl-admin.lan

    Server:         192.168.8.1
    Address:        192.168.8.1#53

    Name:   gl-admin.lan
    Address: 192.168.8.1

### Change location for separe webui

    mkdir /glinet-firmware
    cp -avr /www /glinet-firmware
    rm -rfv /www/*
    mv /glinet-firmware /www
    cp /www/glinet-firmware/api /www/api
    rm /www/glinet-firmware/api

### Update fast-cgi configuration

Remove the fast-cgi from general config (/etc/lighttpd/lighttpd.conf) and copy past the cgi config into /etc/lighttpd/conf.d/30-fastcgi.conf

        fastcgi.server = (
                "/api" => (
                        "api.handler" => (
                                "socket" => "/tmp/api.socket",
                                "check-local" => "disable",
                                "bin-path" => "/www/api",
                                "max-procs" => 1,
                                "allow-x-send-file" => "enable"
                            )
                         )
        )

### add the openwrt repository

        nano /etc/opkg/distfeeds.conf

        # Openwrt Package 19.07.9
        src/gz openwrt_core http://downloads.openwrt.org/releases/19.07.9/targets/ath79/generic/packages
        src/gz openwrt_kmods http://downloads.openwrt.org/releases/19.07.9/targets/ath79/generic/kmods/4.14.267-1>
        src/gz openwrt_base http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/base
        src/gz openwrt_freifunk http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/freifunk
        src/gz openwrt_luci http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/luci
        src/gz openwrt_packages http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/packages
        src/gz openwrt_routing http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/routing
        src/gz openwrt_telephony http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/telephony

        opkg update 

### Make VHOST in lighttpd

        opkg install lighttpd-mod-simple_vhost

        Installing lighttpd-mod-simple_vhost (1.4.55-1) to root...
        Downloading http://downloads.openwrt.org/releases/19.07.9/packages/mips_24kc/packages/lighttpd-mod-simple_vhost_1.4.55-1_mips_24kc.ipk
        Configuring lighttpd-mod-simple_vhost.

Configure the vhosts : 

        server.modules += ( "mod_simple_vhost" )

        $HTTP["host"] =~ "^gl-admin.h(\:[0-9]*)?$" { 
            dir-listing.activate = "disable" 
            server.document-root = "/www/glinet-firmware/"
            $HTTP["url"] =~ "^/cgi-bin" {
                cgi.assign += ( "" => "" )
            }
        }

        $HTTP["host"] =~ "^pineapple.h(\:[0-9]*)?$" { 
            dir-listing.activate = "disable" 
            server.document-root = "/www/pineapple"
            url.redirect = ( "^/config/" => "/www/status-403.html",
                            "^/data/" => "/www/status-403.html",
                          )
        }

# Source link

Amazon link: https://www.amazon.com/GL-iNet-GL-AR300M16-Ext-Pre-Installed-Performance-Programmable/dp/B07794JRC5

Firmware ofw (OEM) : https://dl.gl-inet.com/?model=ar300m16

Firmware upgrade : https://docs.gl-inet.com/en/3/tutorials/firmware_upgrade/

Unbrick router: https://docs.gl-inet.com/en/2/troubleshooting/debrick/

open source code : https://openwrt.org/toh/gl.inet/gl-ar300m

Quick start guide: https://docs.gl-inet.com/en/3/setup/mini_router/first_time_setup/

Firmware source code : https://github.com/gl-inet/openwrt

LAMP Stack: https://openwrt.org/docs/guide-user/services/webserver/lamp#lighttpd1

Lighthttpd: https://openwrt.org/docs/guide-user/services/webserver/lighttpd

WiFi Pineapple Cloner : https://github.com/xchwarze/wifi-pineapple-cloner

WiFi pineaplle Pannel : https://github.com/xchwarze/wifi-pineapple-panel

WiFi pinneapple Reverse Ingeneering : https://samy.link/blog/build-your-own-wifi-pineapple-tetra-for-7

