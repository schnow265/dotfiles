autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

COMPLETION_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh/completions"
fpath=($COMPLETION_DIR $fpath)

autoload -U compinit
compinit
# WHY WON'T YOU WORK OTHERWISE YOU FUCKING PIECE OF SHIT
zinit light Aloxaf/fzf-tab

zinit as"program" from"gh-r" for ajeetdsouza/zoxide
eval "$(zoxide init zsh --cmd cd)"
