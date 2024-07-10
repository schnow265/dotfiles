{ inputs, lib, config, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nixos"; # IMPORTANT: Change these lines for xour own config.
  home.homeDirectory = "/home/nixos";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.nix-prefetch-git

    # Shell
    pkgs.zinit
    pkgs.fzf
    pkgs.zoxide
    pkgs.atuin
    pkgs.oh-my-posh

    # Manuals
    pkgs.tlrc    
    pkgs.man
    pkgs.man-pages
    pkgs.manix
    pkgs.mandown
    pkgs.nvimpager

    # Tools
    pkgs.lsd
    pkgs.traceroute
    pkgs.btop
    pkgs.bitwarden-cli
    pkgs.inetutils
    pkgs.fnm
    pkgs.nodePackages_latest.pnpm
    pkgs.jq
    pkgs.yt-dlp
    pkgs.gnupg
    pkgs.python311
    pkgs.bun
    pkgs.dig
    pkgs.nmap
    pkgs.ruby
    pkgs.nmap
    pkgs.tree
    pkgs.imagemagick

    # Compilers & libs
    pkgs.libgcc
    pkgs.libgccjit
    pkgs.binutils
    pkgs.glibc
    pkgs.dotnetCorePackages.sdk_9_0
    pkgs.gnumake
    pkgs.cmake
    pkgs.ansible
    pkgs.crystal
    pkgs.icr
    pkgs.flutter
    pkgs.fpm
    pkgs.mu
    pkgs.zig
    pkgs.rustc
    pkgs.cargo
    pkgs.python311Packages.pytest
    pkgs.python311Packages.nose
    pkgs.pipenv
    pkgs.python312Packages.isort
    pkgs.python311Packages.pyflakes
    pkgs.python312Packages.black
    pkgs.faust
    pkgs.cljfmt
    pkgs.clj-kondo
    pkgs.rust-analyzer

    # Linters & Formatters
    pkgs.dockfmt
    pkgs.editorconfig-core-c
    pkgs.tenv
    pkgs.clang-tools
    pkgs.libxml2
    pkgs.fprettify
    pkgs.html-tidy
    pkgs.jsbeautifier
    pkgs.rstfmt
    pkgs.shfmt
    pkgs.shellcheck
    pkgs.nixfmt-rfc-style
    pkgs.ktlint
 
    # Funny Stuff (TM)
    pkgs.hollywood
    pkgs.direnv
    pkgs.isync

    # Frameworks and even older compilers
    pkgs.php

    # Ocaml
    pkgs.ocamlPackages.ocamlformat
    pkgs.ocamlPackages.utop
    pkgs.ocamlPackages.ocp-indent
    pkgs.dune_3

    # Ruby Gems
    pkgs.rubyPackages.rails
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

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
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.configFile.nvim = {
    source = ~/dotfiles/nvim;
    recursive = true;
  };

  xdg.configFile.doom = {
    source = ~/dotfiles/doom;
    recursive = true;
  };

  programs.neovim.plugins = [
   pkgs.vimPlugins.nvim-treesitter.withAllGrammars
  ];

  programs.tmux = {
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
	contimuum
	better-mouse-mode
      ];
    extraConfig = ''
    # unbind C-b
    # set-option -g prefix C-Space
    # bind-key C-Space send-prefix

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
  
  programs.neovim = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "scal Scalet Luca Emanuel";
    userEmail = "scal@keba.com";
    extraConfig = {
      credential = { helper = "store"; };
      init = { defaultBranch = "master"; };
    };
  };

  programs.zsh = {
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
      eval "$(oh-my-posh init zsh --config /home/nixos/.hl-omp.json)"
      eval "$(fnm env --use-on-cd)"
      eval "$(fzf --zsh)"
      eval "$(atuin init zsh)"
      eval "$(zoxide init zsh)"

      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

      clear
    '';
    shellAliases = {
      ll = "lsd -Alg";
      ls = "lsd -g";
      update = "sudo nixos-rebuild switch";
      update-home = "home-manager switch";
      cls = "clear";
      fzf="fzf --preview='cat {}'";
      cd="z";
      cp = "rsync";
      emacs = "emacs -nw";
      doom = "~/.config/emacs/bin/doom";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
