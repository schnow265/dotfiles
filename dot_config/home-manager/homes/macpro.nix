{ config, pkgs, scal, ... }:

let
  coreutilsBin = scal.lib.coreutilsBin { inherit pkgs; };
in {
  home.username = "scaletto";
  home.homeDirectory = "/Users/scaletto";

  home.packages = [
    pkgs.aria2
    pkgs.asdf-vm
    pkgs.bat
    pkgs.btop
    pkgs.ccache
    pkgs.chezmoi
    pkgs.clang
    pkgs.cosign
    pkgs.delta
    pkgs.devenv
    pkgs.emacs
    pkgs.fd
    pkgs.ffmpeg
    pkgs.fontconfig
    pkgs.gh
    pkgs.git-lfs
    pkgs.git-xet
    pkgs.glab
    pkgs.graphviz
    pkgs.lazygit
    pkgs.lua
    pkgs.luarocks
    pkgs.neovim
    pkgs.nil
    pkgs.nixd
    pkgs.nixfmt
    pkgs.plantuml
    pkgs.qemu
    pkgs.ripgrep
    pkgs.tlrc
    pkgs.tmux
    pkgs.topgrade
    pkgs.tree-sitter
    pkgs.uv

    pkgs.bruno
    pkgs.direnv
    pkgs.lsd
    pkgs.mole-cleaner
    pkgs.sourcegit
    pkgs.vlc-bin
  ];

  home.sessionVariables = {
    CMAKE_INSTALL_PREFIX="/Users/scaletto/.local_builds/";
  };
}
