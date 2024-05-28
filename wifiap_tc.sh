#!/bin/sh

ifconfig wlan0 down
ifconfig wlan0 10.30.1.1

hostapd /etc/hostapd/hostapd.conf &
dhcpcd wlan0
dnsmasq --interface=wlan0
