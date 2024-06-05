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
    sudo apt install -y snapd
fi

declare -A tools
tools["mobile_beginner"]="intellij-idea-community"
tools["mobile_intermediate"]="android-studio"
tools["website_beginner"]="code node"
tools["website_intermediate"]="code postman node"

display_banner

echo "Selamat datang di installasi PLUGIN."
echo "1) Squad Web"
echo "2) Squad Mobile"
read -p "Silakan pilih squad: " squad_choice

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

echo "Menginstal tools untuk $squad $level..."
for tool in $selected_tools; do
    echo "Menginstal $tool..."
    sudo snap install $tool --classic
done

echo "menginstall discord....."
sudo snap install discord

if [ "$squad" == "mobile" ]; then
    echo "Mengunduh dan menginstal JDK 21..."
    wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz
    sudo mkdir -p /usr/lib/jvm
    sudo tar -xzf jdk-21_linux-x64_bin.tar.gz -C /usr/lib/jvm

    # Set up environment variables
    echo "export JAVA_HOME=/usr/lib/jvm/jdk-21" >> ~/.bashrc
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
    source ~/.bashrc

    echo "JDK 21 telah terinstal."
fi

echo "Instalasi selesai."
