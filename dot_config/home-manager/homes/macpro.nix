{
  pkgs,
  scal,
  ...
}:

let
  binExtract = scal.lib.binExtract { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    borgbackup
    ffmpeg-full
    yt-dlp

    blender
    mole-cleaner

    zed-editor
  ];

  home.sessionVariables = {
    CMAKE_INSTALL_PREFIX = "/Users/scaletto/.local_builds/";
    HF_HUB_CACHE = "/Users/scaletto/LLama";
    CC = "/usr/bin/clang";
    CXX = "/usr/bin/clang++";
  };
}
