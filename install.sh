mkdir -p ~/.config/nvim
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp ./nvim/init.vim ~/.config/nvim/init.vim
cp ./tmux/.tmux.conf ~/
sh ./ohmyzsh
sh ./fzf
