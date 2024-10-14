#!/bin/bash
matrix_animation() {
    clear
    echo -e "\e[32m"  
    for i in {1..100}; do
        line=""
        for j in {1..80}; do
            line+=$(printf "\\$(printf '%03o' $((RANDOM%57+33)))")
        done
        echo "$line"
        sleep 0.05  
    done
    echo -e "\e[0m"  
}

display_welcome_and_countdown() {
    clear
    echo "Welcome to the Network Client!"
    echo "Booting up client in 5 seconds..."
    for i in {5..1}; do
        echo "$i..."
        sleep 1
    done
}

matrix_animation
display_welcome_and_countdown
python3 src/main.py
