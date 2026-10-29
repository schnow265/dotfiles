{
  pkgs,
  username,
  enableGuiTools ? false,
  inputs,
  ...
}:
let
  binExtract = inputs.scal.lib.binExtract { inherit pkgs; };

  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  path = if isDarwin then "/Users" else "/home";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  #
  # Paths set automagically
  home.username = username;
  home.homeDirectory = "${path}/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages =
    with pkgs;
    [
      aria2
      bat
      btop
      chezmoi
      delta
      devenv
      direnv
      lsd
      ripgrep
      tlrc
    ]
    ++ (if enableGuiTools then [ keepassxc ] else [ (binExtract pkgs.keepassxc "keepassxc-cli") ]);

  home.sessionVariables = {
    # other ones
    HF_HUB_DISABLE_XET = "1";
    UV_TORCH_BACKEND = "auto";
  };

  home.file = {
    ".local/share/external/zsh/nixos-completions".source = inputs.nixZshCompletions;
  };

  home.shell.enableShellIntegration = true;

  programs.ghostty = {
    enable = enableGuiTools;
    package = (if isLinux then pkgs.ghostty else pkgs.ghostty-bin);

    enableZshIntegration = true;
    installBatSyntax = true;
    settings = {
      #theme = "Nvim Dark";
      font-family = "JetBrains Mono";
      font-family-bold = "JetBrains Mono";
      font-family-italic = "JetBrains Mono";
      font-family-bold-italic = "JetBrains Mono";
      font-feature = "-calt, -liga, -dlig";
      gtk-titlebar = false;
      macos-secure-input-indication = false;
      auto-update = "off";
    };
  };

  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        cleanup = true;
        assume_yes = true;

        first = [
          "chezmoi"
          "home_manager"
        ];

        disable = [
          "system"
          "shell"
          "vim"
          "pnpm"
          "mise"
          "node"
        ]
        ++ pkgs.lib.optionals isLinux [
          "config_update"
        ]
        ++ pkgs.lib.optionals isDarwin [
          "ruby_gems"
          "gem"
          "tmux"
        ];

        ignore_failures = [
          "powershell"
          "nix"
          "pi"
        ]
        ++ pkgs.lib.optionals isDarwin [
          "containers"
          "vagrant"
        ];
      };

      git = {
        max_concurrency = 10;
        repos = [
          "~/Projects/*/"
        ];
        arguments = "--ff-only";
      };
      commands = {
        "Nix Profiles" = "nix profile upgrade --all";
      };
    };
  };

  programs.zsh = {
    enable = true;
    initContent = ''
      # Keybindings
      bindkey " " magic-space

      autoload -Uz edit-command-line
      zle -N edit-command-line
      bindkey '^X^E' edit-command-line

      bindkey '^[.' insert-last-word
      bindkey '^[_' copy-prev-word

      bindkey '^[[1;5C' forward-word
      bindkey '^[[1;5D' backward-word

      bindkey '^A' beginning-of-line
      bindkey '^E' end-of-line

      bindkey '^W' backward-kill-word
      bindkey '^H' backward-delete-char
      bindkey '^K' kill-line
      bindkey '^U' backward-kill-line

      bindkey '^/' undo
      bindkey '^?' backward-delete-char
      bindkey '^[/' redo

      source "$HOME/.config/zsh/config.zsh"

      fastfetch

      case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac
      [[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
    '';
    envExtra = ''
      export PATH="/Users/scaletto/.local/bin:$PATH"
    '';
    profileExtra = ''
      # Added by Toolbox App
      export PATH="$PATH:/Users/scaletto/Library/Scripts/JB_Toolbox/"

      eval "$(/opt/homebrew/bin/brew shellenv zsh)"

      case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac
    '';

    # History
    history = {
      path = "$HOME/.zsh_history";
      size = 50000;
      save = 50000;

      ignoreDups = true;
      ignoreSpace = true;

      share = true;
    };

    # Shell options
    setOptions = [
      "INC_APPEND_HISTORY"
    ];

    # Dedicated Home Manager integrations
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Additional plugins
    plugins = [
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
    ];
    shellAliases = {
      cls = "clear";

      ls = "lsd";
      ll = "lsd -Al";

      cat = "bat";
      nvy = "neovide";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
