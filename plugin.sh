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
    sudo apt install -y snapd
fi

declare -A tools
tools["mobile_beginner"]="intellij-idea-community openjdk-11-jdk"
tools["mobile_intermediate"]="openjdk-11-jdk android-studio"
tools["website_beginner"]="code"
tools["website_intermediate"]="code postman"

display_banner

echo "Selamat datang di installasi PLUGIN."
echo "1) Squad Web"
echo "2) Squad Mobile"
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
echo "1. Beginner"
echo "2. Intermediate"
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


function is_snap_package {
    snap find "$1" | grep -q "^Name"
    return $?
}


function is_apt_package {
    apt-cache show "$1" > /dev/null 2>&1
    return $?
}

echo "Menginstal tools untuk $squad $level..."
for tool in $selected_tools; do
    if is_snap_package "$tool"; then
        echo "Menginstal $tool menggunakan snap..."
        sudo snap install $tool
    elif is_apt_package "$tool"; then
        echo "Menginstal $tool menggunakan apt..."
        sudo dnf install  $tool
    else
        echo "Tool $tool tidak ditemukan di snap atau apt."
        exit 1
    fi
done

echo "Instalasi selesai."
