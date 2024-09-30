#!/bin/bash

function display_banner {
    echo -e "\e[1;32m"
    echo "██████╗ ██╗     ██╗   ██╗ ██████╗ ██╗███╗   ██╗"
    echo "██╔══██╗██║     ██║   ██║██╔════╝ ██║████╗  ██║"
    echo "██████╔╝██║     ██║   ██║██║  ███╗██║██╔██╗ ██║"
    echo "██╔═══╝ ██║     ██║   ██║██║   ██║██║██║╚██╗██║"
    echo "██║     ███████╗╚██████╔╝╚██████╔╝██║██║ ╚████║"
    echo "╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝"
    echo -e "\e[0m"
}

# Instalasi snapd jika belum terpasang
if ! command -v snap >/dev/null; then
    echo "Snap tidak terdeteksi. Menginstal snapd..."
    sudo apt update
    sudo apt install snapd
fi

declare -A tools
tools["mobile_kotlin"]="intellij-idea-community"
tools["frontend"]="code"
tools["backend"]="code docker postman"

display_banner

echo "Selamat datang di instalasi PLUGIN."
echo "1) Squad Mobile Kotlin"
echo "2) Squad Frontend"
echo "3) Squad Backend"
read -p "Silakan pilih squad: " squad_choice

case $squad_choice in
    1)
        squad="mobile_kotlin"
        ;;
    2)
        squad="frontend"
        ;;
    3)
        squad="backend"
        ;;
    *)
        echo "Pilihan tidak valid"
        exit 1
        ;;
esac

selected_tools=${tools[$squad]}

if [ -z "$selected_tools" ]; then
    echo "Tidak ada tools untuk pilihan Anda."
    exit 1
fi

echo "Menginstal tools untuk $squad..."
for tool in $selected_tools; do
    echo "Menginstal $tool..."
    sudo snap install $tool --classic
done

echo "Instalasi selesai."

