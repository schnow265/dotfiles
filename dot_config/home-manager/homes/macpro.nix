{
  pkgs,
  scal,
  masterPkgs,
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
    bruno
    en-croissant
    mole-cleaner
    prismlauncher
    vlc-bin

    # extracted binarys
    #(binExtract android-tools "adb")
  ];

  home.sessionVariables = {
    CMAKE_INSTALL_PREFIX = "/Users/scaletto/.local_builds/";
    HF_HUB_CACHE = "/Users/scaletto/LLama";
  };
}
