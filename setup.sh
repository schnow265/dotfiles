# Symlink home-manager config.
# Please back up your original config file. Otherwise the script will move it to a .bak file.
[ -f ~/.config/home-manager/home.nix ] && mv ~/.config/home-manager/home.nix ~/.config/home-manager/home.nix.bak
ln -s ~/dotfiles/home-manager.nix ~/.config/home-manager/home.nix

home-manager switch

# Load doomemacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
rm -rf ~/.emacs ~/.emacs.d
~/.config/emacs/bin/doom sync

# install sdkman
curl -s "https://get.sdkman.io?rcupdate=false" | bash
