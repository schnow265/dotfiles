{ inputs, lib, config, pkgs, ... }:
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

    packages = with pkgs; [
      zip
      unzip
      # Nix Tools
        nix-prefetch-git

      # Tools
        ## CLI Tools
          coreutils

          ### Artifacts
            jfrog-cli

          ### Automation
            docker

          ### Shell Tools
            zinit
            atuin
            oh-my-posh
            btop
            lsd

            #### File Traversal & searches
              fzf
              zoxide
              tree
              fd
              ripgrep

          ### Authentication & encryption
            bitwarden-cli
            gnupg

          ### Network
            inetutils
            nmap
            dig

          ### Node Package Managers & JS compilers
            fnm
            nodePackages_latest.pnpm
            bun
            nodejs_18
          ### Parsers
            jq

          ### backups
            borgbackup

          ### Downoaders
            yt-dlp

          ### Convertors
            imagemagick

          ### Environment Manager
            direnv
            tenv

          ### Syncs
            #### MBox
              isync
              mu

      # Programming Tools
        ## Rust
          cargo
          rustc
          rust-analyzer
          rstfmt
        ## PHP
          php
        ## Ruby
          ruby
          ### Gems
            rubyPackages.rails
        ## Python stuff and pip packages
          python311
          pipenv

          ### Python 3.11 Packages
            python311Packages.pytest
            python311Packages.nose

          ### Python 3.12 Packages
            python312Packages.isort
            python311Packages.pyflakes
            python312Packages.black
        ## The C family (someone will hate this.)
          ### C#
            dotnetCorePackages.sdk_9_0
            #### F#
              fprettify
          ### C/C++
            clang
            gnumake
            cmake
            # Libraries
              libgcc
              libgccjit
              glibc
              libxml2
              ncurses
        ## Web development
          html-tidy
          jsbeautifier
        ## Java/Kotlin
          ktlint
        ## Shell Scripts
          shellcheck
          shfmt
        ## Nix
          nixfmt-rfc-style
        ## Languages with too little packages for an own category
          cljfmt
          clj-kondo

      # Documentation
        man
        man-pages
        manix
        mandown

        ## Man-Browsers
          tlrc

      # Build Tools
        fpm
        dockfmt

      # Editors
        editorconfig-core-c
        emacs
        nvimpager
	vscode

      # Fun
        hollywood
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
