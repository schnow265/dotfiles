{ config, ... }:
let
  pkgsUnstable = import <nixpkgs-unstable> {
    overlays = [
      (import (
        builtins.fetchTarball "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz"
      ))
      (import (builtins.fetchTarball "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz"))
    ];
  };
in
{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home = {
    # Home Manager needs a bit of information about you and the paths it should manage.
    username = "schnow265"; # IMPORTANT: Change these lines for your own config.
    homeDirectory = "/home/schnow265";

    # This value determines the Home Manager release that your configuration is compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgsUnstable; [
      ansible_2_15
      atuin
      bitwarden-cli
      bitwarden-desktop
      borgbackup
      btop
      bun
      cargo
      clang
      clj-kondo
      cljfmt
      cmake
      coreutils
      dig
      devenv
      direnv
      docker
      dockfmt
      dotnetCorePackages.sdk_9_0
      editorconfig-core-c
      emacs
      fd
      flutter
      fnm
      fpm
      fprettify
      fzf
      gh
      glibc
      gnumake
      gnupg
      go
      goread
      hollywood
      html-tidy
      imagemagick
      inetutils
      isync
      jetbrains-toolbox
      jfrog-cli
      jq
      jsbeautifier
      kmon
      ktlint
      latest.firefox-nightly-bin
      lazygit
      libgcc
      libgccjit
      libxml2
      lsd
      man-pages
      mandown
      manix
      mu
      ncurses
      nix-prefetch-git
      nixfmt-rfc-style
      nmap
      nodejs_18
      nodePackages_latest.pnpm
      oh-my-posh
      php
      pipenv
      pulsar
      python311
      python311Packages.nose
      python311Packages.pyflakes
      python311Packages.pytest
      python312Packages.black
      python312Packages.isort
      ripgrep
      rstfmt
      ruby
      rubyPackages.rails
      rust-analyzer
      rustc
      shellcheck
      shfmt
      stylelint
      stylelint-lsp
      tenv
      tlrc
      tree
      unzip
      vitetris
      vscode
      yt-dlp
      zinit
      zip
      zoxide
    ];

    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;
      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';

      ".schnowprompt.json".source = ./oh-my-posh.json;
    };

    sessionVariables = {
      # Home Manager can also manage your environment variables through
      # 'home.sessionVariables'. These will be explicitly sourced when using a
      # shell provided by Home Manager. If you don't want to manage your shell
      # through Home Manager then you have to manually source 'hm-session-vars.sh'
      # located at either
      #
      #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      #
      # or
      #
      #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
      #
      # or
      #
      #  /etc/profiles/per-user/nixos/etc/profile.d/hm-session-vars.sh
      #
      EDITOR = "nvim";
    };
  };

  # Config files located in .config/
  xdg = {
    configFile = {
      btop = {
        source = ./config/btop;
        recursive = true;
      };
      doom = {
        source = ./config/doom;
        recursive = true;
      };
      goread = {
        source = ./config/goread;
        recursive = true;
      };
      nvim = {
        source = ./config/nvim;
        recursive = true;
      };
    };
  };

  # All program options
  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };

    neovim = {
      enable = true;
      plugins = with pkgsUnstable.vimPlugins; [ nvim-treesitter.withAllGrammars ];
    };

    tmux = {
      enable = true;
      shell = "${pkgsUnstable.zsh}/bin/zsh";
      terminal = "tmux-256color";
      historyLimit = 100000;
      plugins = with pkgsUnstable.tmuxPlugins; [
        better-mouse-mode
        better-mouse-mode
        mode-indicator
        nord
        prefix-highlight
        resurrect
        sensible
        session-wizard
        tmux-fzf
        weather
      ];
      extraConfig = ''
        set-option -sa terminal-features ",xterm*:RGB"

        set -g @session-wizard 'T'

        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        set-option -g mouse on

        set -g base-index 1
        set -g pane-base-index 1
      '';
    };

    git = {
      enable = true;
      userName = "schnow265";
      userEmail = "thesnowbox@icloud.com";
      extraConfig = {
        credential = {
          helper = "store";
        };
        init = {
          defaultBranch = "master";
        };
      };
    };

    # Shells
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        source ${pkgsUnstable.zinit}/share/zinit/zinit.zsh

        zinit light zsh-users/zsh-syntax-highlighting
        zinit light zsh-users/zsh-completions
        zinit light zsh-users/zsh-autosuggestions

        zinit light atuinsh/atuin
        zinit light Aloxaf/fzf-tab
	zinit light chisui/zsh-nix-shell

        zstyle ':completion:*' matcher-list 'm:{a-z}={S-Za-z}'
        zstyle ':completion:*' list-colors "§{(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

        autoload -U compinit && compinit
        zinit cdreplay -q


        # Evaluate Helperscripts
        eval "$(oh-my-posh init zsh --config ~/.schnowprompt.json)"
        eval "$(fnm env --use-on-cd)"
        eval "$(fzf --zsh)"
        eval "$(atuin init zsh)"
        eval "$(zoxide init zsh)"

        export SDKMAN_DIR="$HOME/.sdkman"
        [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

        clear
      '';
      shellAliases = {
        cd = "z";
        cls = "clear";
        doom = "~/.config/emacs/bin/doom";
        emacs = "emacs -nw";
        fzf = "fzf --preview='cat {}'";
        ll = "lsd -Al";
        ls = "lsd";
        rsync = "rsync --progress";
        update = "nixos-rebuild switch --use-remote-sudo; nix store gc";
        update-home = "home-manager switch; nix store gc";
      };
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
    };

    bash = {
      initExtra = ''
        export SDKMAN_DIR="$HOME/.sdkman"
        [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
      '';
      shellAliases = {
        cd = "z";
        cls = "clear";
        fzf = "fzf --preview='cat {}'";
      };
    };
  };
}
