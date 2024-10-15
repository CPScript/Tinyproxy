## Overview of Tinyproxy
>Tinyproxy is a lightweight HTTP/HTTPS proxy that allows you to route your internet traffic through it. This is useful for various applications, including web browsing, content filtering, and privacy enhancement.

## How Tinyproxy Works
* Proxy Setup: Tinyproxy listens on a specified port and allows client devices to connect to it.
* Request Handling: When a client makes a request through the proxy, Tinyproxy forwards this request to the target server and relays the response back to the client.
* Access Control: You can configure which devices can connect to the proxy by specifying IP addresses or ranges in the configuration file.
Prerequisites
* Termux: Make sure you have the Termux app installed on your Android device.
* Network: Ensure that your device is connected to a Wi-Fi network where other devices can reach it.

## Installation and Setup Steps
* Update Termux: Start by updating the package lists:
```
pkg update -y && pkg upgrade -y
```

* Install Dependencies: Install Python and Tinyproxy:

```
pkg install -y python tinyproxy
```

* Configure Tinyproxy: 
Create a setup script to automate the configuration of Tinyproxy. Here’s the script that includes everything you need: (already uploaded to the repo `setup.sh`)

```bash
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

# Check if the configuration file exists
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

```

## Explanation of Key Configurations
* Allowing Connections: The script allows local connections from the device itself (127.0.0.1) and from the local network (192.168.0.0/16). You may need to adjust this based on your network setup.

* Port Configuration: Tinyproxy is set to listen on port `8888`. Make sure this port is open and not used by any other services.

Binding: By using Bind `0.0.0.0`, Tinyproxy listens on all interfaces, allowing other devices on the same network to connect.

## Running the Proxy Server
* Run the Setup Script: Save the script as setup.sh, give it executable permissions, and run it:
```
chmod +x setup.sh
./setup.sh
```
* Check the Log: If you encounter any issues, check the log file located at `/data/data/com.termux/files/usr/var/log/tinyproxy.log` for errors.

* Test Connectivity: On another device connected to the same network, configure your web browser or device settings to use the proxy:

* Proxy IP: Use the IP address of your Termux device.
* Proxy Port: Use `8888`.

## Expected Output
* Setup Completion: The script should confirm the completion of setup without errors.
* Log File Creation: A log file should be created at the specified location.
* Connection Tests: When configured correctly, you should be able to browse the internet using the proxy without issues.

## Troubleshooting
* If Tinyproxy doesn't start, check the log file for errors.
* Ensure your firewall (if any) allows traffic through port 8888.
* Verify that the IP address you are using to connect to the proxy is correct.
