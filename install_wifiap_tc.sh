#!/bin/sh

tce-load -wi wireless-$(uname -r) nano dnsmasq dhcpcd hostapd

sudo ./install_wifiap_tc_root.sh
