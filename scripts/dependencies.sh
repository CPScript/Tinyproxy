#!/bin/bash

echo "Installing necessary packages..."
if command -v apt-get &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y curl wget git tinyproxy 3proxy openvpn wireguard iptables
elif command -v yum &>/dev/null; then
    sudo yum install -y curl wget git tinyproxy 3proxy openvpn wireguard iptables
else
    echo "Unsupported package manager. Please install dependencies manually."
    exit 1
fi
