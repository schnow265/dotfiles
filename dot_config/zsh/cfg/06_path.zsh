# PATH expansion

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

[[ -d "$HOME/.aspire/bin" ]] && export PATH="$HOME/.aspire/bin:$PATH"
[[ -d "$HOME/.local/share/gem/ruby/3.4.0/bin" ]] && export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"
[[ -d "$HOME/.dotnet/tools" ]] && export PATH="$PATH:$HOME/.dotnet/tools"

# pnpm
if [ -d "$HOME/.local/share/pnpm" ]; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi
# pnpm end.
