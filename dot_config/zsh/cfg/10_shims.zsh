# Base directory
BIN_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh/bin"
SHIM_DIR="$BIN_DIR/.shims"

mkdir -p "$SHIM_DIR"

# Add base bin and shims to PATH
path=("$BIN_DIR" "$SHIM_DIR" $path)

# Rebuild shims on shell startup
rm -f "$SHIM_DIR"/*(N)

for subdir in "$BIN_DIR"/*(/); do
  name="${subdir:t}"
  for file in "$subdir"/*(.x); do
    shim="$SHIM_DIR/${name}_${file:t}"
    cat > "$shim" <<EOF
#!/usr/bin/env zsh
exec "$file" "\$@"
EOF
    chmod +x "$shim"
  done
done
