#!/bin/bash

get_public_ip() {
    curl -s https://api.ipify.org
}

get_local_ip() {
    hostname -I | awk '{print $1}'
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
    echo "Connect your device using this proxy:"
    echo "Set proxy to: $LocalIP:4444"
    echo "Make sure to allow connections from your device."
    echo
    echo "Action buttons"
    echo
    echo "[START] Press 's' to toggle the proxy"
    echo "[Q] Press 'q' to quit"
}

Uptime="0m 0s"
ConnectionStatus="Stopped"
PublicIP=$(get_public_ip)
LocalIP=$(get_local_ip)

# Main loop
while true; do
    display_status
    read -n 1 input
    case $input in
        s|S)
            if [ "$ConnectionStatus" = "Stopped" ]; then
                mitmproxy --listen-host 0.0.0.0 -p 4444 &  
                ConnectionStatus="Running"
                Uptime="0m 0s"
                while [ "$ConnectionStatus" = "Running" ]; do
                    sleep 1
                    Uptime=$(date -u -d @$(( $(date +%s) - $(date -d "$Uptime" +%s) )) +'%Mm %Ss')
                done
            else
                pkill mitmproxy  
                ConnectionStatus="Stopped"
            fi
            ;;
        q|Q)
            pkill mitmproxy  
            exit 0
            ;;
    esac
done
