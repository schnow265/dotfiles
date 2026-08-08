# schnpow265's stupid dotfiles

> terrible life descisions in dotfiles.

## Install using Nix (new and fancy)

Only needs nix installed. Chezmoi will be added via home-manager.

```bash
nix run nixpkgs#chezmoi -- init https://gitlab.com/schnow265/dotfiles.git
# apply non-verbose, since the diff helper delta will be installed via home-manager
nix run nixpkgs#chezmoi -- apply

# do home-manager
nix run home-manager/master -- switch
```

## Contains configs for

- zsh
- nvim (via external repo)
- tmux
- tmuxinator
- btop
- yt-dlp
- topgrade stuff
- nix home-manager
- and a lot more...
