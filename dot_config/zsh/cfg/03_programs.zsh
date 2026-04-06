zinit as"program" from"gh-r" for kitware/cmake
zinit as"program" from"gh-r" for ccache/ccache
zinit as"program" from"gh-r" for @astral-sh/uv

zinit as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' pick"direnv" src"zhook.zsh" for direnv/direnv
