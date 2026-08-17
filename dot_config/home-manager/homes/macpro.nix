{
  config,
  pkgs,
  scal,
  ...
}:

let
  binExtract = scal.lib.binExtract { inherit pkgs; };
in
{
  home.username = "scaletto";
  home.homeDirectory = "/Users/scaletto";

  home.packages = with pkgs; [
    ffmpeg-full
    yt-dlp

    beekeeper-studio
    bruno
    doomrunner
    mole-cleaner
    uzdoom
    vlc-bin

    # extracted binarys
    (binExtract android-tools "adb")

    (sourcegit.overrideAttrs (oldAttrs: {
      runtimeDeps = (oldAttrs.runtimeDeps or [ ]) ++ [
        git-lfs
      ];
    }))
  ];

  home.sessionVariables = {
    CMAKE_INSTALL_PREFIX = "/Users/scaletto/.local_builds/";
  };
}
