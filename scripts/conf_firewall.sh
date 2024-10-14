#!/bin/bash

echo "Configuring firewall..."
sudo iptables -A INPUT -p tcp --dport 8888 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 1080 -j ACCEPT
sudo iptables -A INPUT -p udp -- dport 1194 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 51820 -j ACCEPT
echo "Firewall configured."
