mkdir -p ~/.config/nvim
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp ./nvim/init.vim ~/.config/nvim/init.vim
cp .tmux.conf ~/
mkdir -p ~/.alacritty
cp alacritty.toml ~/.config/alacritty/alacritty.toml
sh ./ohmyzsh
sh ./fzf

cat << 'EOF' >> ~/.zshrc
alias ra='. ranger'
alias lg='lazygit'
alias n='nvim'
alias ns='nvim `fzf`'
alias s='vim `fzf`'
git config --global credential.helper store
EOF
