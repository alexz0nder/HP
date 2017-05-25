#!/bin/bash
node_name=`hostname`
bios_version=`sudo dmidecode -s bios-version`
bios_release_date=`sudo dmidecode -s bios-release-date`
hdd_controller_firmware=`sudo hpacucli controller all show detail | grep Firmware`
hdd_controller_firmware_array=( $hdd_controller_firmware )
hdd_controller_firmware=${hdd_controller_firmware_array[2]}
net_interfaces=`cat /proc/net/bonding/bond0 | grep Interface`
net_interfaces_array=( $net_interfaces )
eth0=${net_interfaces_array[2]}
eth1=${net_interfaces_array[5]}
eth2=${net_interfaces_array[8]}
eth3=${net_interfaces_array[11]}
eth0_fw=`sudo ethtool -i ${eth0} | grep firmware | sed 's/firmware-version: //'`
eth1_fw=`sudo ethtool -i ${eth1} | grep firmware | sed 's/firmware-version: //'`
eth2_fw=`sudo ethtool -i ${eth2} | grep firmware | sed 's/firmware-version: //'`
eth3_fw=`sudo ethtool -i ${eth3} | grep firmware | sed 's/firmware-version: //'`
echo "${node_name}, ${bios_version}, ${bios_release_date}, ${hdd_controller_firmware}, ${eth0}, ${eth0_fw}, ${eth1}, ${eth1_fw}, ${eth2}, ${eth2_fw}, ${eth3}, ${eth3_fw}"
