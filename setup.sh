# Symlink home-manager config.
# Please back up your original config file"

ln -s ~/dotfiles/home-manager.nix ~/.config/home-manager/home.nix

# Load doomemacs

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

rm -rf ~/.emacs ~/.emacs.d

~/.config/emacs/bin/doom sync
