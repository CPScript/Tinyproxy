#!/bin/bash

echo "Configuring logging..."
sudo mkdir -p /var/log/proxy-vpn-setup
sudo touch /var/log/proxy-vpn-setup/setup.log
sudo chmod 600 /var/log/proxy-vpn-setup/setup.log

echo "Logging configured."
