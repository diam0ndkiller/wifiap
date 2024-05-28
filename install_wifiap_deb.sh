#!/bin/sh

apt install dnsmasq dhcpcd5 hostapd

modprobe ath5k

cp /etc/dhcpcd.conf /etc/dhcpcd.conf.old
echo interface wlan0 >> /etc/dhcpcd.conf
echo     static ip_address=10.30.1.1/24 >> /etc/dhcpcd.conf
echo     nohook wpa_supplicant >> /etc/dhcpcd.conf
nano /etc/dhcpcd.conf

wget -O /etc/dnsmasq-blocklist.txt https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
nano /etc/dnsmasq-blocklist.txt

cp /etc/dnsmasq.conf /etc/dnsmasq.conf.old
cp ./dnsmasq.conf /etc/dnsmasq.conf
nano /etc/dnsmasq.conf

mkdir -p /etc/hostapd/
cp /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf.old
cp ./hostapd.conf /etc/hostapd/hostapd.conf
nano /etc/hostapd/hostapd.conf

cp ./get-connections.sh /etc/hostapd/get-connections.sh
nano /etc/hostapd/get-connections.sh
chmod +x /etc/hostapd/get-connections.sh

echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
echo net.ipv6.ip_forward=1 >> /etc/sysctl.conf

mkdir -p /var/lib/misc/

cp ./unblock-wifi.service /etc/systemd/system/
cp ./iptables-postrouting.service /etc/systemd/system/
nano /etc/systemd/system/iptables-postrouting.service

systemctl daemon-reload

systemctl unmask hostapd
systemctl enable hostapd
systemctl enable dnsmasq
systemctl enable dhcpcd
systemctl disable systemd-resolved
systemctl disable NetworkManager
systemctl enable unblock-wifi
systemctl enable iptables-postrouting
