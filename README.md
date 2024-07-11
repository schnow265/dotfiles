# My Dotfiles

> This config assumes that you have the [Nix Package Manager](https://nixos.org/download) and [home-manager](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone) installed on your system.

## Getting started

Please make a backup of your home-manager config file located in ``~/.config/home-manager`` and remove the original file named ``home.nix`` because the script will symlink my config to that exact file.

After removing your original home-manager config file, you can run

```shell
bash setup.sh
```

This script will also download [Doom Emacs](https://github.com/doomemacs/doomemacs). 

## What is included
