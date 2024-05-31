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
tools["mobile_beginner"]="intellij-idea-community"
tools["mobile_intermediate"]="android-studio"
tools["website_beginner"]="code"
tools["website_intermediate"]="code postman"

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

if [ "$squad" == "website" ]; then
    echo "Mengunduh dan menginstal NVM (Node Version Manager)..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    # Load NVM for current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

    echo "Mengunduh dan menginstal Node.js versi 18 menggunakan NVM..."
    nvm install 18
    nvm use 18
    nvm alias default 18

    # Add NVM initialization to /etc/profile to make it available globally
    echo 'export NVM_DIR="$HOME/.nvm"' | sudo tee -a /etc/profile
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' | sudo tee -a /etc/profile

    echo "Node.js versi 18 telah terinstal."
fi

echo "Instalasi selesai."
