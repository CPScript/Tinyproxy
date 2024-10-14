#!/bin/bash

# Function to install necessary packages
install_dependencies() {
    echo "Installing necessary packages..."
    if command -v apt-get &>/dev/null; then
        sudo apt-get update
        sudo apt-get install -y curl wget git
    elif command -v yum &>/dev/null; then
        sudo yum install -y curl wget git
    fi
}

# Function to set up a proxy server
setup_proxy() {
    echo "Choose Proxy Type:"
    echo "1. HTTP Proxy (Tinyproxy)"
    echo "2. SOCKS Proxy (3proxy)"

    read -p "Enter your choice (1 or 2): " proxy_choice

    case $proxy_choice in
        1)
            echo "Setting up HTTP Proxy with Tinyproxy..."
            sudo apt-get install -y tinyproxy
            sudo sed -i 's/Allow 127.0.0.1/Allow ALL/' /etc/tinyproxy/tinyproxy.conf
            sudo systemctl restart tinyproxy
            echo "HTTP Proxy setup complete. Connect using your server's IP and port 8888."
            ;;
        2)
            echo "Setting up SOCKS Proxy with 3proxy..."
            sudo apt-get install -y 3proxy
            echo "socks -p1080" > ~/3proxy.cfg
            3proxy ~/3proxy.cfg
            echo "SOCKS Proxy setup complete. Connect using your server's IP and port 1080."
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
}

# Function to set up a VPN
setup_vpn() {
    echo "Choose VPN Type:"
    echo "1. OpenVPN"
    echo "2. WireGuard"

    read -p "Enter your choice (1 or 2): " vpn_choice

    case $vpn_choice in
        1)
            echo "Setting up OpenVPN..."
            wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh
            echo "OpenVPN setup complete. Use the generated .ovpn file to connect."
            ;;
        2)
            echo "Setting up WireGuard..."
            sudo apt-get install -y wireguard
            # Simplified WireGuard setup
            echo "WireGuard setup complete. Follow additional instructions for configuration."
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
}

# Main menu
main_menu() {
    echo "Welcome to the Proxy/VPN Setup Script"
    echo "Please choose an option:"
    echo "1. Set up a Proxy"
    echo "2. Set up a VPN"

    read -p "Enter your choice (1 or 2): " choice

    case $choice in
        1)
            setup_proxy
            ;;
        2)
            setup_vpn
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
}

# Run the script
install_dependencies
main_menu
