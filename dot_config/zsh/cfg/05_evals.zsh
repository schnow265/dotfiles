zinit as"program" from"gh-r" for starship/starship
eval "$(starship init zsh)"

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

eval "$(direnv hook zsh)"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
