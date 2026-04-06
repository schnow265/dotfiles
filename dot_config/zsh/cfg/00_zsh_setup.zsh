HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# welcome to my keybinds

bindkey " " magic-space

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

bindkey '^[.' insert-last-word      # Alt+.
bindkey '^[_' copy-prev-word        # Alt+_

bindkey '^[[1;5C' forward-word      # Ctrl+Right
bindkey '^[[1;5D' backward-word     # Ctrl+Left
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

bindkey '^W' backward-kill-word     # Delete previous word
bindkey '^H' backward-delete-char   # Backspace (reliable)
bindkey '^K' kill-line              # Kill to end of line
bindkey '^U' backward-kill-line     # Kill to beginning

bindkey '^/' undo
bindkey '^?' backward-delete-char
bindkey '^[/' redo

source /usr/share/fzf/key-bindings.zsh
