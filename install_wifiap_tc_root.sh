#!/bin/sh

tce-load -wi wireless-$(uname -r) dnsmasq dhcpcd hostapd iptables

modprobe ath5k

cp /etc/dhcpcd.conf /etc/dhcpcd.conf.old
echo interface wlan0 >> /etc/dhcpcd.conf
echo     static ip_address=10.30.1.1/24 >> /etc/dhcpcd.conf
echo     nohook wpa_supplicant >> /etc/dhcpcd.conf

wget -O /etc/dnsmasq-blocklist.txt https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
nano /etc/dnsmasq-blocklist.txt

cp /etc/dnsmasq.conf /etc/dnsmasq.conf.old
cp ./dnsmasq.conf /etc/dnsmasq.conf
nano /etc/dnsmasq.conf

mkdir -p /etc/hostapd/
cp /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf.old
cp ./hostapd.conf /etc/hostapd/hostapd.conf
nano /etc/hostapd/hostapd.conf

echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
echo net.ipv6.ip_forward=1 >> /etc/sysctl.conf

mkdir -p /var/lib/misc/

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

echo 1 > /proc/sys/net/ipv4/ip_forward
