#!/bin/sh
# usage: ./second_dhclient.sh eth0
dev="${1:-eth0}" 
nr="$(ip a | grep "^[0-9]*: $dev" | wc -l)" 
name="$(echo "$dev" | sed 's/[^0-9a-fA-F]//g' | head -c 1)" 
mac="ac:ac:1a:b0:a0:$name$nr" 
set -e -x
mac="ac:ac:1a:b0:a0:$name$nr" 
dhclient $dev
ip1=$(ip route show | grep default)
ipgw=$(echo $ip1 | sed 's/.* \([0-9]\+\(\.[0-9]\+\)\{3\}\).*/\1/')
ifconfig $dev down
ifconfig $dev 192.168.0.9 netmask 255.255.255.0 up
route add default gw $ipgw $dev
ifconfig $dev up
echo "nameserver 8.8.8.8" > /etc/resolv.conf
sudo ip link add link $dev address $mac $dev.$nr type macvlan
ifconfig $dev.$nr 192.168.0.42 netmask 255.255.255.0 up

