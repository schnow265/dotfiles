{ inputs, lib, config, pkgs, ... }:
let
  pkgsUnstable = import <nixpkgs-unstable> {};
in
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
  ];

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

    packages = with pkgsUnstable;  [
      zip
      unzip
      nix-prefetch-git
      coreutils
      jfrog-cli
      docker
      zinit
      atuin
      oh-my-posh
      btop
      lsd
      fzf
      zoxide
      tree
      fd
      ripgrep
      bitwarden-cli
      gnupg
      inetutils
      nmap
      dig
      fnm
      nodePackages_latest.pnpm
      bun
      nodejs_18
      jq
      borgbackup
      yt-dlp
      imagemagick
      direnv
      tenv
      isync
      mu
      cargo
      rustc
      rust-analyzer
      rstfmt
      php
      ruby
      rubyPackages.rails
      python311
      pipenv
      python311Packages.pytest
      python311Packages.nose
      python312Packages.isort
      python311Packages.pyflakes
      python312Packages.black
      dotnetCorePackages.sdk_9_0
      fprettify
      clang
      gnumake
      cmake
      libgcc
      libgccjit
      glibc
      libxml2
      ncurses
      html-tidy
      jsbeautifier
      ktlint
      shellcheck
      shfmt
      nixfmt-rfc-style
      cljfmt
      clj-kondo
      man
      man-pages
      manix
      mandown
      tlrc
      fpm
      dockfmt
      editorconfig-core-c
      emacs
      nvimpager
      vscode
      hollywood
      goread
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
      nvim = {
        source = ./config/nvim;
        recursive = true;
      };
      doom = {
        source = ./config/doom;
        recursive = true;
      };
      btop = {
        source = ./config/btop;
	      recursive = true;
      };
      goread = {
        source = ./config/goread;
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
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];
    };

    tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
      historyLimit = 100000;
      plugins = with pkgs.tmuxPlugins; [
          nord
          sensible
          better-mouse-mode
          weather
          session-wizard
          tmux-fzf
          mode-indicator
          prefix-highlight
          resurrect
          better-mouse-mode
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
        credential = { helper = "store"; };
        init = { defaultBranch = "master"; };
      };
    };

    # Shells
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        source ${pkgs.zinit}/share/zinit/zinit.zsh

        zinit light zsh-users/zsh-syntax-highlighting
        zinit light zsh-users/zsh-completions
        zinit light zsh-users/zsh-autosuggestions

        zinit light atuinsh/atuin
        zinit light Aloxaf/fzf-tab

        zstyle ':completion:*' matcher-list 'm:{a-z}={S-Za-z}'
        zstyle ':completion:*' list-colors "§{(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

        autoload -U compinit && compinit
        zinit cdreplay -q


        # Evaluate Helperscripts
        eval "$(oh-my-posh init zsh --config /home/schnow265/.schnowprompt.json)"
        eval "$(fnm env --use-on-cd)"
        eval "$(fzf --zsh)"
        eval "$(atuin init zsh)"
        eval "$(zoxide init zsh)"

        export SDKMAN_DIR="$HOME/.sdkman"
        [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

        clear
      '';
      shellAliases = {
        ll = "lsd -Al";
        ls = "lsd";
        update = "sudo nixos-rebuild switch & nix store gc";
        update-home = "home-manager switch & nix store gc";
        cls = "clear";
        fzf="fzf --preview='cat {}'";
        cd="z";
        emacs = "emacs -nw";
        doom = "~/.config/emacs/bin/doom";
	      rsync = "rsync --progress";
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
        cls = "clear";
        fzf = "fzf --preview='cat {}'";
        cd = "z";
      };
    };
  };  
}
