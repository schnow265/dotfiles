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

## List of flake inputs

| Name              | URL                                        | Description                                                                                          |
| ----------------- | ------------------------------------------ | ---------------------------------------------------------------------------------------------------- |
| nixpkgs           | `github:nixos/nixpkgs/nixpkgs-unstable`    | Default unstable nix pkgs                                                                            |
| home-mamnager     | `github:nix-community/home-manager`        | home-manager path                                                                                    |
| nixmaster         | `github:nixos/nixpkgs`                     | The latest nixpkgs commit, only used in case of build issues                                         |
| scal              | `github:schnow265/scaletto.nix`            | my utility functions                                                                                 |
| nvimConfig        | `gitlab:schnow265/nvim.conf`               | my [neovim config](https://gitlab.com/schnow265/nvim.conf.git) tracked via flake for easier updating |
| nixZshCompletions | `github:nix-community/nix-zsh-completions` | zsh completions for the `nix` CLI                                                                    |
| chemacs2_git | `github:plexus/chemacs2` | emacs profile switcher; only used when `apps/editors/emacs.nix` is included |
| spacemacs_git | `github:syl20bnr/spacemacs` | spacemacs base. |
| kakoune_kaktree | `github:andreyorst/kaktree` | the [kaktree plugin](https://github.com/andreyorst/kaktree). only used when kakoune is enabled |
