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
    sudo apt install snapd
fi

declare -A tools
tools["mobile_beginner"]="intellij-idea-community openjdk-21-jdk"
tools["mobile_intermediate"]="openjdk-21-jdk android-studio"
tools["website_beginner"]="code"
tools["website_intermediate"]="code postman"

display_banner

echo "Selamat datang di installer prasyarat PLUGIN."
echo "1) Pengembangan Web"
echo "2) Pengembangan Mobile"
read -p "Silakan pilih skuat: " squad_choice

case $squad_choice in
    1)
        squad="website"
        ;;
    2)
        squad="mobile"
        ;;
    *)
        echo "Pilihan tidak valid"
        exit 1
        ;;
esac

echo "Pilih level Anda:"
echo "1. Pemula"
echo "2. Menengah"
read -p "Pilih batch atau level: " level_choice

case $level_choice in
    1)
        level="beginner"
        ;;
    2)
        level="intermediate"
        ;;
    *)
        echo "Pilihan tidak valid"
        exit 1
        ;;
esac

selected_tools_key="${squad}_${level}"
selected_tools=${tools[$selected_tools_key]}

if [ -z "$selected_tools" ]; then
    echo "Tidak ada tools untuk pilihan Anda."
    exit 1
fi

echo "Menginstal tools untuk $squad $level..."
for tool in $selected_tools; do
    echo "Menginstal $tool..."
    sudo snap install $tool --classic
done

echo "Instalasi selesai."

