# Collect Ruby gem bin directories from common locations
typeset -U path

gem_roots=(
  "$HOME/.gem/ruby"
  "$HOME/.local/share/gem/ruby"
)

for root in $gem_roots; do
  [[ -d "$root" ]] || continue

  for version_dir in "$root"/*; do
    [[ -d "$version_dir" ]] || continue

    bin_dir="$version_dir/bin"
    [[ -d "$bin_dir" ]] && path=("$bin_dir" $path)
  done
done

export PATH
