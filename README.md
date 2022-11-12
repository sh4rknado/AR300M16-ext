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
    nslookup gl-admin.lan

### Make VHOST in lighttpd


## Change loclation of gli-net webui to www/gli-frimware



# source link

Amazon link: https://www.amazon.com/GL-iNet-GL-AR300M16-Ext-Pre-Installed-Performance-Programmable/dp/B07794JRC5

Firmware ofw (OEM) : https://dl.gl-inet.com/?model=ar300m16

Firmware upgrade : https://docs.gl-inet.com/en/3/tutorials/firmware_upgrade/

Unbrick router: https://docs.gl-inet.com/en/2/troubleshooting/debrick/

open source code : https://openwrt.org/toh/gl.inet/gl-ar300m

Quick start guide: https://docs.gl-inet.com/en/3/setup/mini_router/first_time_setup/

Firmware source code : https://github.com/gl-inet/openwrt

LAMP Stack: https://openwrt.org/docs/guide-user/services/webserver/lamp#lighttpd1

Lighthttpd: https://openwrt.org/docs/guide-user/services/webserver/lighttpd
