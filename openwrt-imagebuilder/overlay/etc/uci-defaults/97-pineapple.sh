# Get Version and Device
if [[ $(cat /proc/cpuinfo | grep 'machine' | awk {'print $6'}) == "NANO" ]]; then
    device="NANO"
elif [[ $(cat /proc/cpuinfo | grep 'machine' | awk {'print $6'}) == "TETRA" ]]; then
    device="TETRA"
fi
version=$(cat /etc/pineapple/pineapple_version | head -c 5)

# Make SSH banner have the correct version and device
eval "sed -i s/VERSION/$version/g /etc/banner"
eval "sed -i s/DEVICE/$device/g /etc/banner"

if [[ $device == "TETRA" ]]; then
	# Remove SD Destination for OPKG
	eval "sed -i 3d /etc/opkg.conf"
	# Configure PATH
	echo "export PATH=/usr/bin/pineapple:/bin:/sbin:/usr/bin:/usr/sbin" >> /etc/profile
fi

if [[ $device == "NANO" ]]; then
	# Configure PATH with SD card directories
	echo "export PATH=/usr/bin/pineapple:/bin:/sbin:/usr/bin:/usr/sbin:/sd/bin:/sd/sbin:/sd/usr/sbin:/sd/usr/bin" >> /etc/profile
	echo "export LD_LIBRARY_PATH=/lib:/usr/lib:/sd/lib:/sd/usr/lib" >> /etc/profile
else
	echo "export LD_LIBRARY_PATH=/lib:/usr/lib" >> /etc/profile
fi	

# Touch known hosts
mkdir -p /root/.ssh/
touch /root/.ssh/known_hosts

# Temporarily soft-link libpcap.so.1 to libpcap.so.1.3
ln -s /usr/lib/libpcap.so.1 /usr/lib/libpcap.so.1.3

# Disable AutoSSH
/etc/init.d/autossh stop
/etc/init.d/autossh disable

# Turn LED solid for Setup
if [[ $device == "NANO" ]]; then
	echo 255 > /sys/class/leds/wifi-pineapple-nano:blue:system/brightness
else
	echo 255 > /sys/class/leds/pineapple-tetra:blue:system/brightness
fi

exit 0
