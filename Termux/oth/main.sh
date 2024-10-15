#!/data/data/com.termux/files/usr/bin/bash

install_mitmproxy() {
    if ! command -v mitmproxy &> /dev/null; then
        echo "mitmproxy not found. Installing..."
        pkg update && pkg install -y mitmproxy
    fi
}

get_public_ip() {
    curl -s https://api.ipify.org
}

get_local_ip() {
    ip addr show wlan0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1
}

display_connected_devices() {
    echo "Connected Devices:"
    arp -n | awk '{print $1, $3}' | grep -v "IP" || echo "No devices connected."
}

deny_mac() {
    local mac=$1
    if iptables -A INPUT -m mac --mac-source "$mac" -j DROP; then
        echo "Denied access to MAC: $mac"
    else
        echo "Failed to deny MAC: $mac"
    fi
}

display_status() {
    clear
    echo "Proxy Server Management"
    echo "========================"
    echo "Status Information"
    echo
    echo "Uptime: $Uptime"
    echo "Connection Status: $ConnectionStatus"
    echo "Public IP: $PublicIP"
    echo "Local IP: $LocalIP"
    echo
    display_connected_devices
    echo
    echo "Connect your device using this proxy:"
    echo "Set proxy to: $LocalIP:4444"
    echo "Make sure to allow connections from your device."
    echo
    echo "Action buttons"
    echo
    echo "[START] Press 's' to toggle the proxy"
    echo "[KICK] Press 'k' to deny a MAC address"
    echo "[Q] Press 'q' to quit"
}

install_mitmproxy

Uptime="0m 0s"
ConnectionStatus="Stopped"
PublicIP=$(get_public_ip)
LocalIP=$(get_local_ip)

while true; do
    display_status
    read -n 1 input
    case $input in
        s|S)
            if [ "$ConnectionStatus" = "Stopped" ]; then
                mitmproxy --listen-host 0.0.0.0 -p 4444 & 
                ConnectionStatus="Running"
                StartTime=$(date +%s) 
                while [ "$ConnectionStatus" = "Running" ]; do
                    sleep 1
                    CurrentTime=$(date +%s)
                    Uptime=$(printf "%dm %ds" $((CurrentTime - StartTime) / 60) $((CurrentTime - StartTime) % 60))
                done
            else
                pkill -f mitmproxy  
                ConnectionStatus="Stopped"
            fi
            ;;
        k|K)
            echo -e "\nEnter the MAC address to deny (format: XX:XX:XX:XX:XX:XX):"
            read mac_address
            deny_mac "$mac_address"
            ;;
        q|Q)
            pkill -f mitmproxy
            exit 0
            ;;
    esac
done
