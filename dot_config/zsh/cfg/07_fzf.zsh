zinit for \
    from'gh-r' as"program" \
  junegunn/fzf


export FZF_CTRL_R_OPTS="
  --reverse
  --preview 'echo {}'
  --preview-window down:3:hidden:wrap
  --bind '?:toggle-preview'
"
