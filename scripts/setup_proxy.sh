#!/bin/bash

setup_http_proxy() {
    echo "Configuring Tinyproxy..."
    sudo sed -i 's/^#Allow 127.0.0.1/Allow 0.0.0.0/' /etc/tinyproxy/tinyproxy.conf
    sudo systemctl restart tinyproxy
    echo "HTTP Proxy setup complete. Connect using your server's IP and port 8888."
}

setup_socks_proxy() {
    echo "Configuring 3proxy..."
    cat <<EOF > ~/3proxy.cfg
socks -p1080
EOF
    3proxy ~/3proxy.cfg &
    echo "SOCKS Proxy setup complete. Connect using your server's IP and port 1080."
}

case $1 in
    http)
        setup_http_proxy
        ;;
    socks)
        setup_socks_proxy
        ;;
    *)
        echo "Invalid proxy type. Use 'http' or 'socks'."
        exit 1
        ;;
esac
