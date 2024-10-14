#!/bin/bash

get_public_ip() {
    echo "$(curl -s https://ipinfo.io/ip)"
}

get_local_ip() {
    echo "$(ip addr show wlan0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)"
}

echo "Updating and upgrading Termux packages..."
pkg update -y && pkg upgrade -y

echo "Installing tinyproxy..."
pkg install -y tinyproxy

CONFIG_PATH="/data/data/com.termux/files/usr/etc/tinyproxy/tinyproxy.conf"

echo "Configuring tinyproxy..."
cp $CONFIG_PATH $CONFIG_PATH.bak

sed -i '/^Allow /d' $CONFIG_PATH
echo "Allow 127.0.0.1" >> $CONFIG_PATH
echo "Allow 192.168.0.0/16" >> $CONFIG_PATH  # Adjust according to your local network

sed -i 's/^Port .*/Port 8888/' $CONFIG_PATH

sed -i 's/^#DisableViaHeader Yes/DisableViaHeader Yes/' $CONFIG_PATH
sed -i 's/^#LogFile "\/var\/log\/tinyproxy.log"/LogFile "\/data\/data\/com.termux\/files\/usr\/var\/log\/tinyproxy.log"/' $CONFIG_PATH
sed -i 's/^#MaxClients 100/MaxClients 100/' $CONFIG_PATH

echo "Starting tinyproxy..."
tinyproxy &

echo "Gathering IP information..."
ORIGINAL_IP=$(get_public_ip)
DEVICE_IP=$(get_local_ip)

echo "Original Public IP: $ORIGINAL_IP"
echo "Device Local IP: $DEVICE_IP"
echo "Proxy Server is running on: $DEVICE_IP:8888"

echo "Configure your device to use this proxy server."
echo "To stop tinyproxy, use 'pkill tinyproxy'."
