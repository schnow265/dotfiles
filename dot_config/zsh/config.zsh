ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


# Directory relative to the current file
local script_dir=${0:A:h}
local src_dir="$script_dir/cfg"

# Source all regular files in alphabetical order
for file in "$src_dir"/*(.oL); do
  source "$file"
done
