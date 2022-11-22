# -- Setup system configuration

# Get device type
if [[ $(cat /proc/cpuinfo | grep 'machine' | awk {'print $6'}) == "NANO" ]]; then
    device="NANO"
elif [[ $(cat /proc/cpuinfo | grep 'machine' | awk {'print $6'}) == "TETRA" ]]; then
    device="TETRA"
fi

# Change the hostname
uci set system.@system[0].hostname=Pineapple
uci commit system
echo $(uci get system.@system[0].hostname) > /proc/sys/kernel/hostname

if [[ $device == "NANO" ]]; then
	uci add system led
	uci set system.@led[-1]=led
	uci set system.@led[-1].name='wlan0'
	uci set system.@led[-1].sysfs='wifi-pineapple-nano:blue:system'
	uci set system.@led[-1].trigger='netdev'
	uci set system.@led[-1].dev='wlan0'
	uci set system.@led[-1].mode='link tx rx'
else
	uci add system led
	uci set system.@led[-1]=led
	uci set system.@led[-1].name='eth0'
	uci set system.@led[-1].sysfs='pineapple-tetra:yellow:eth0'
	uci set system.@led[-1].trigger='netdev'
	uci set system.@led[-1].dev='eth0'
	uci set system.@led[-1].mode='link tx rx'

	uci add system led
	uci set system.@led[-1]=led
	uci set system.@led[-1].name='wlan0'
	uci set system.@led[-1].sysfs='pineapple-tetra:blue:system'
	uci set system.@led[-1].trigger='netdev'
	uci set system.@led[-1].dev='wlan0'
	uci set system.@led[-1].mode='link tx rx'

	uci add system led
	uci set system.@led[-1]=led
	uci set system.@led[-1].name='wlan1'
	uci set system.@led[-1].sysfs='pineapple-tetra:red:wlan1mon'
	uci set system.@led[-1].trigger='netdev'
	uci set system.@led[-1].dev='wlan1mon'
	uci set system.@led[-1].mode='link tx rx'
fi

exit 0
