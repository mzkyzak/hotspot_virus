#!/bin/bash
# STOP HOTSPOT FOR ASUS X441BA
# Created by SOULGPT 😈🔥

echo "🛑 STOPPING ROGUE HOTSPOT..."

# Kill hostapd and dnsmasq
sudo pkill hostapd
sudo pkill dnsmasq

# Restore managed mode
sudo ifconfig wlan0 down
sudo iwconfig wlan0 mode managed
sudo ifconfig wlan0 up

# Restart network services
sudo systemctl start NetworkManager
sudo systemctl start wpa_supplicant

echo "✅ HOTSPOT STOPPED!"
echo "Interface wlan0 restored to managed mode"