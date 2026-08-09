{ config, pkgs, scal, ... }:

let
  binExtract = scal.lib.binExtract { inherit pkgs; };
in {
  home.username = "scaletto";
  home.homeDirectory = "/Users/scaletto";

  home.packages = [
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

    # extracted binarys
    (binExtract pkgs.android-tools "adb")
  ];

  home.sessionVariables = {
    CMAKE_INSTALL_PREFIX="/Users/scaletto/.local_builds/";
  };
}
