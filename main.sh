#!/bin/bash

animation() {
    clear
    echo -e "\e[32m"  

    
    for _ in {1..20}; do
        line=""
        for _ in {1..20}; do
            line+=$(printf "\\$(printf '%03o' $((RANDOM%57+33)))")
        done
        echo "$line"
        sleep 0.01
    done

    
    for _ in {1..4}; do
        tput cuu1  
        tput el    
        sleep 0.01
    done

    echo -e "\e[0m"  
}

message() {
    clear
    echo "Welcome to the Client!"
    sleep 2
    clear
}

echo "This doesn't do anything, its just a animation!"
sleep 1
clear
animation
message

python3 src/menu.py
