# fetch latest release (adjust version if needed)
curl -Lo nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
# optional: move to /usr/local/bin
sudo mv nvim.appimage /usr/local/bin/nvim
# run as: nvim

