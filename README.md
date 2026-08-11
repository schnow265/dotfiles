# schnpow265's stupid dotfiles

> terrible life descisions in dotfiles.

Contains configs for:

- nix home-manager
- zsh
- nvim
- tmux
- btop
- yt-dlp
- topgrade stuff
- and a lot more...

## Installation

Either you grab chezmoi from your distro and then run `chezmoi init https://gitlab.com/schnow265/dotfiles.git && chezmoi apply`, or just use Nix.

### Install using Nix

Only needs nix installed. Chezmoi will be added via home-manager.

```bash
nix --extra-experimental-features nix-command --extra-experimental-features flakes run nixpkgs#chezmoi -- init https://gitlab.com/schnow265/dotfiles.git
nix --extra-experimental-features nix-command --extra-experimental-features flakes run nixpkgs#chezmoi -- apply

# do home-manager
nix run home-manager/master -- switch
```

### Notes on installation (especially Home Manager related settings)

- The flags for experimental features are only required before the initial apply, since [I set those in the user's nix.conf file](./dot_config/nix/nix.conf)
- The determinate systems nix update path is also configured since nix successfully downgraded itself on the default path on my machine
- A matching user config [has to be set in home-manager's `flake.nix`](./dot_config/home-manager/flake.nix)
- zsh is not installed via home-manager, it has to be provided by your system.
- [Doom Emacs](https://github.com/doomemacs/core/tree/master#doom-emacs) has been included and is ready to set up by running `doom sync`
