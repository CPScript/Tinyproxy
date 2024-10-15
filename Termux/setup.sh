#!/bin/bash

is_installed() {
    pkg list-installed | grep -q "^$1/"
}

echo "Updating and upgrading Termux packages..."
if ! pkg update -y && pkg upgrade -y; then
    echo "Failed to update packages. Please check your network or repository settings."
    exit 1
fi

if is_installed "python"; then
    echo "Python is already installed."
else
    echo "Installing Python..."
    pkg install -y python
fi

if is_installed "tinyproxy"; then
    echo "Tinyproxy is already installed."
else
    echo "Installing Tinyproxy..."
    if ! pkg install -y tinyproxy; then
        echo "Failed to install Tinyproxy. Please check your repository settings."
        exit 1
    fi
fi

echo "Configuring Tinyproxy"
CONFIG_PATH="/data/data/com.termux/files/usr/etc/tinyproxy/tinyproxy.conf"

if [ ! -f "$CONFIG_PATH" ]; then
    echo "Configuration file not found. Creating a default configuration..."
    cp /data/data/com.termux/files/usr/etc/tinyproxy/tinyproxy.conf.default "$CONFIG_PATH"
fi

echo "Backing up original configuration file"
if [ ! -f "$CONFIG_PATH.bak" ]; then
    cp "$CONFIG_PATH" "$CONFIG_PATH.bak"
    echo "Backup of tinyproxy.conf created."
else
    echo "Backup already exists."
fi

echo "Allowing local connections"
sed -i '/^Allow /d' "$CONFIG_PATH"
echo "Allow 127.0.0.1" >> "$CONFIG_PATH"
echo "Allow 192.168.0.0/16" >> "$CONFIG_PATH"  

echo "Setting the port for Tinyproxy"
sed -i 's/^Port .*/Port 8888/' "$CONFIG_PATH"

echo "Enabling logging"
sed -i 's/^#LogFile "\/var\/log\/tinyproxy.log"/LogFile "\/data\/data\/com.termux\/files\/usr\/var\/log\/tinyproxy.log"/' "$CONFIG_PATH"
sed -i 's/^#MaxClients 100/MaxClients 100/' "$CONFIG_PATH"

LOG_DIR="/data/data/com.termux/files/usr/var/log/"
mkdir -p "$LOG_DIR"
touch "${LOG_DIR}/tinyproxy.log"

if ! grep -q "^Bind" "$CONFIG_PATH"; then
    echo "Adding Bind address to configuration..."
    echo "Bind 0.0.0.0" >> "$CONFIG_PATH"  
fi

echo "Starting Tinyproxy..."
tinyproxy -d

echo "Tinyproxy configuration is complete."
echo "Setup completed. You can now run the proxy manager."
