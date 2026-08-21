if [[ -d /nix ]] && ! command -v nix >/dev/null 2>&1; then
    print "Nix is installed but the 'nix' command is not available on your PATH."
    print "Please run: sudo fix-nix"
fi
