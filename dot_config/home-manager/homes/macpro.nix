{ config, pkgs, scal, ... }:

let
  binExtract = scal.lib.binExtract { inherit pkgs; };
in {
  home.username = "scaletto";
  home.homeDirectory = "/Users/scaletto";

  home.packages = with pkgs; [
    cosign
    ffmpeg-full

    bruno
    mole-cleaner
    sourcegit
    vlc-bin
    yt-dlp

    # extracted binarys
    (binExtract android-tools "adb")
  ];

  home.sessionVariables = {
    CMAKE_INSTALL_PREFIX="/Users/scaletto/.local_builds/";
  };
}
