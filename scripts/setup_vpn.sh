#!/bin/bash

setup_openvpn() {
    echo "Setting up OpenVPN..."
    wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh
    echo "OpenVPN setup complete. Use the generated .ovpn file to connect."
}

setup_wireguard() {
    echo "Setting up WireGuard..."
    sudo apt-get install -y wireguard
    sudo mkdir -p /etc/wireguard
    sudo chmod 600 /etc/wireguard

    server_private_key=$(wg genkey)# Generate server private and public keys
    server_public_key=$(echo $server_private_key | wg pubkey)

    cat <<EOF | sudo tee /etc/wireguard/wg0.conf 
[Interface]
PrivateKey = $server_private_key
Address = 10.0.0.1/24
ListenPort = 51820
SaveConfig = true

PostUp = sysctl -w net.ipv4.ip_forward=1
PostDown = sysctl -w net.ipv4.ip_forward=0

[Peer]
# Client configuration
PublicKey = CLIENT_PUBLIC_KEY
AllowedIPs = 10.0.0.2/32
EOF

    sudo systemctl start wg-quick@wg0
    sudo systemctl enable wg-quick@wg0

    echo "WireGuard setup complete. Configure clients with the appropriate keys and IPs."
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
