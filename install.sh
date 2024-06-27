#!/bin/bash

Applications=('htop' 'git' 'tmux' 'ranger' 'neofetch' 'curl' 'wget' 'snapd' 'net-tools' 'nmon' 'glances' 'zsh' 'unzip' 'lsd' 'tcptrack')

setup() {
    clear
}

update_apt() {
    sudo apt update >/dev/null 2>&1 && sudo apt full-upgrade -y >/dev/null 2>&1 &&
        echo "Apt is now up to date."
}

install_applications() {

    for pkg in "${Applications[@]}"; do
        echo "$pkg"
        sudo apt install "$pkg" >/dev/null 2>&1 && echo "Installed '$pkg'" || echo "Failed to install '$pkg.'"
    done
}

install_fonts() {
    fontname="Mononoki"
    url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Mononoki.zip"

    mkdir "$fontname"
    cd "$fontname"
    wget "$url" >/dev/null 2>&1 && echo "Downloaded $fontname" || echo "Failed to download $fontname"
    unzip "$fontname".zip && echo "Unzipped $fontname."
    cd ..
    mv Mononoki ~/.local/share/fonts/
    fc-cache -fv >/dev/null 2>&1 && echo "Installed $fontname." || echo "Failed to install $fontname."

}

install_gh() {
    sudo mkdir -p -m 755 /etc/apt/keyrings
    wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null && echo "Downloded github-cli" || echo "Failed to download github-cli."
    sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null 2>&1
    sudo apt update >/dev/null 2>&1
    sudo apt install gh -y >/dev/null 2>&1 && echo "Installed github-cli." || echo "Failed to install github-cli."
}

install_ohmyzsh() {
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
}

setup
update_apt
install_applications
install_fonts
install_gh
install_ohmyzsh
