#!/bin/bash

setup_openvpn() {
    echo "Setting up OpenVPN..."
    wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh
    echo "OpenVPN setup complete. Use the generated .ovpn file to connect."
}

setup_wireguard() {
    echo "Setting up WireGuard..."
    sudo apt-get install -y wireguard
    echo "WireGuard setup complete. Follow additional instructions for configuration."
}

case $1 in
    openvpn)
        setup_openvpn
        ;;
    wireguard)
        setup_wireguard
        ;;
    *)
        echo "Invalid VPN type. Use 'openvpn' or 'wireguard'."
        exit 1
        ;;
esac
