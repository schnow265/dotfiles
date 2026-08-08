{ config, pkgs, scal, ... }:

let
  coreutilsBin = scal.lib.coreutilsBin { inherit pkgs; };
in {
  home.username = "scaletto";
  home.homeDirectory = "/Users/scaletto";

  home.packages = [
    pkgs.asdf-vm
    pkgs.ccache
    pkgs.clang
    pkgs.cosign
    pkgs.ffmpeg
    pkgs.lazygit
    pkgs.nil
    pkgs.nixd
    pkgs.nixfmt

    pkgs.bruno
    pkgs.mole-cleaner
    pkgs.sourcegit
    pkgs.vlc-bin
  ];

  home.sessionVariables = {
    CMAKE_INSTALL_PREFIX="/Users/scaletto/.local_builds/";
  };
}
