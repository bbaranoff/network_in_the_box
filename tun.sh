#!/bin/sh
sudo ip tuntap add dev apn0 mode tun user $USER group $USER
sudo ip addr add 192.168.42.0/24 dev apn0
sudo ip link set apn0 up

