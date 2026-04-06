# schnow265's zsh config

To install, replace/add this snippet into your `.zshrc`:

```zsh
ZSH_CFG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"
[ ! -d $ZSH_CFG_HOME/.git ] && git clone https://github.com/schnow265/zsh.conf.git "$ZSH_CFG_HOME"
source "${ZSH_CFG_HOME}/config.zsh"
```

## WARNING

This will install **a lot** of stuff. Among them:

- `zinit`
- [my nvim config](https://github.com/schnow265/nvim.conf.git) if you don't have your own.
- the folliowing CLI utils via `zinit as"program"`:
    - [nvim](https://github.com/neovim/neovim.git)
    - [fzf](https://github.com/junegunn/fzf.git)
    - [btop](https://github.com/aristocratos/btop)
    - [SDKMAN](https://sdkman.io)
    - [direnv](https://github.com/direnv/direnv.git)
    - [fizsh](https://github.com/zsh-users/fizsh.git)
- Shell completions with [FZF tab configured](./cfg/99_completions.zsh)
- [My keybinds](./cfg/00_zsh_setup.zsh)
- [env exports](./cfg/09_env.zsh). for example `EDITOR` to `nvim`
- my "weird" aliases. [have a look](./cfg/04_aliases.zsh).
- some [plugins](./cfg/02_zsh_plugins.zsh) I find useful.
- my [extremely crappy scripts](./bin/). These are loaded [via shims](./cfg/10_shims.zsh) if there are files in subfolders.
