#!/bin/bash

echo "Welcome."
echo "Please choose an option:"
echo "1. Set up a Proxy"
echo "2. Set up a VPN"
echo "99. EXIT"

read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        echo "Setting up Proxy..."
        ;; # Call proxy setup function from a diffrent folder
    2)
        echo "Setting up VPN..."
        ;;
    99)
        echo "stopping script"
      exit 1
    *)
        echo "Invalid choice"         # Call VPN setup function
        ;;
esac
