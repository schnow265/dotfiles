alias drop_cache="echo 'sync; echo 3 > /proc/sys/vm/drop_caches' | sudo bash"
alias cls=clear
alias oil="NVIM_APPNAME=nvim-oil nvim ."
command -v lsd >/dev/null 2>&1 && alias ls=lsd
command -v lsd >/dev/null 2>&1 && alias ll="lsd -Al"
command -v zk >/dev/null 2>&1 && alias kasten="zk --notebook-dir=$HOME/Documents/zettelkasten"
command -v bat >/dev/null 2>&1 && alias cat=bat
command -v terraform >/dev/null 2>&1 && alias tf=terraform
