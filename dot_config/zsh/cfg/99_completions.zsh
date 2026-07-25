source $HOME/.local/share/external/zsh/nixos-completions/nix-zsh-completions.plugin.zsh # nix completions are SO weird.

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

COMPLETION_DIR="${HOME}/.config/zsh/completions/"
fpath=("${HOME}/.local/share/external/zsh/nixos-completions/" $COMPLETION_DIR $fpath "${HOME}/.local/share/external/zsh/completions/")

autoload -U compinit
compinit
# WHY WON'T YOU WORK OTHERWISE YOU FUCKING PIECE OF SHIT
zinit light Aloxaf/fzf-tab

zinit as"program" from"gh-r" for ajeetdsouza/zoxide
eval "$(zoxide init zsh --cmd cd)"
