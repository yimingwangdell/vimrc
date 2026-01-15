#!/bin/bash

# Define usage function
usage() {
    echo "Usage: $0 <command>"
    echo "Available commands:"
    echo "  all        Install all components"
    echo "  tmux       Install tmux plugins"
    echo "  nvim       Setup nvim configuration"
    echo "  nvimlatest Install latest nvim"
    echo "  alacritty  Setup alacritty configuration"
    echo "  ohmyzsh    Install ohmyzsh"
    echo "  fzf        Install fzf"
    echo "  zsh        Configure zsh with aliases"
    echo "  ranger     Install ranger"
    echo "  nerdfont   Install nerdfont"
    echo "  i3         Install i3"
    echo "  sway       Install sway"
    echo "  jdtls      Install jdtls"
    exit 1
}

# Check for command argument
if [ "$#" -ne 1 ]; then
    usage
fi

# Command variable
COMMAND=$1

# Function to install tmux plugins
install_tmux() {
    mkdir -p ~/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp .tmux.conf ~/
}

# Function to setup nvim
install_nvim() {
    mkdir -p ~/.config/nvim
    cp ./nvim/init.vim ~/.config/nvim/init.vim
    cp -r ./nvim/ftplugin ~/.config/nvim/
}

install_nvim_latest() {
    curl -Lo nvim.appimage   https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.appimage
    chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
}

# Function to setup alacritty
install_alacritty() {
    mkdir -p ~/.config/alacritty
    cp alacritty.yml ~/.config/alacritty/alacritty.yml
}

# Function to install ohmyzsh
install_ohmyzsh() {
    sh ./ohmyzsh
}

# Function to install fzf
install_fzf() {
    sh ./fzf
}

# Function to configure zsh
configure_zsh() {
    cat << 'EOF' >> ~/.zshrc
alias ra='. ranger'
alias lg='lazygit'
alias n='nvim'
alias ns='nvim `fzf`'
alias s='vim `fzf`'
export VISUAL='nvim'
git config --global credential.helper store
EOF
}

# Function to install ranger
install_ranger() {
    cp -r ranger ~/.config/
}

install_i3() {
    cp -r i3 ~/.config/
    cp -r i3status ~/.config/
}

install_sway() {
    mkdir -p ~/.config/sway
    cp sway ~/.config/sway/config
    apt install wl-clipboard
}

install_jdtls() {
    mkdir -p /root/workspace/jdtls/1.36
    cd /root/workspace/jdtls/1.36
    wget https://www.eclipse.org/downloads/download.php\?file\=/jdtls/milestones/1.36.0/jdt-language-server-1.36.0-202405301306.tar.gz
    tar -xf *.tar.gz
    rm *.tar.gz
    if java -version 2>&1 | grep -qE 'version "11\.|openjdk 11'; then
      echo ""
    else
      echo "Not JDK 11 plese make sure java --version is jdk 11"
    fi
}

# Function to nerdfont
install_nerdfont() {
    sh ./nerdfont
}

# Install all components
install_all() {
    install_tmux
    install_nvim
    install_alacritty
    install_ohmyzsh
    install_fzf
    configure_zsh
    install_ranger
    install_sway
    install_jdtls
}

# Execute command based on user input
case $COMMAND in
    all)
        install_all
        ;;
    tmux)
        install_tmux
        ;;
    nvim)
        install_nvim
        ;;
    nvimlatest)
        install_nvim_latest
        ;;
    alacritty)
        install_alacritty
        ;;
    ohmyzsh)
        install_ohmyzsh
        ;;
    fzf)
        install_fzf
        ;;
    zsh)
        configure_zsh
        ;;
    ranger)
        install_ranger
        ;;
    i3)
        install_i3
        ;;
    sway)
        install_sway
        ;;
    jdtls)
        install_jdtls
        ;;
    nerdfont)
        install_nerdfont
        ;;
    *)
        usage
        ;;
esac
