zinit as"program" from"gh-r" for starship/starship
eval "$(starship init zsh)"

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"
