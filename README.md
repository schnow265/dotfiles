# My Dotfiles

> This config assumes that you have the [Nix Package Manager](https://nixos.org/download) and [home-manager](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone) installed on your system.

## Getting started

Please make a backup of your home-manager config file located in ``~/.config/home-manager`` and remove the original file named ``home.nix`` because the script will symlink my config to that exact file.

After removing your original home-manager config file, you can run

```shell
bash setup.sh
```

This script will also download [Doom Emacs](https://github.com/doomemacs/doomemacs). 

## What is included?

- zsh is the default shell with some [aliases](#aliases) and using zinit as the plugin manager.
- tmux with 'a few' plugins
- my neovim config
- [Doom Emacs](https://github.com/doomemacs/doomemacs) as the emacs distro used.
- my git config. Please update it to your name and email.
- modified oh-my-posh prompt to not show the git repo status since it would lag the hell out of my prompt.
- [SDKMAN](https://sdkman.io/) configured for use
- Using ``emacs-git`` for emacs, replace it with ``èmacs`` if you don't want to compile emacs from source. (I like dev builds, this is why I use the master commit. Also I trust the master branch to have a somewhat-stable commit)

## My "special" configs

### The Prompt

![My Prompt based on the half-life design](assets/prompt.png)

### Aliases

| Alias | original command |
| ----- | ---------------- |
| ll | lsd -Al |
| ls | lsd |
| update | sudo nixos-rebuild switch & nix store gc |
| update-home | home-manager switch & nix store gc |
| cls | clear |
| fzf | fzf --preview='cat {}' |
| cd | z |
| emacs | emacs -nw |
| doom | ~/.config/emacs/bin/doom |
| rsync | rsync --progress |
