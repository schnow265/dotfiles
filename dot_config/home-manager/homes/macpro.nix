{
  config,
  pkgs,
  scal,
  masterPkgsDarwin,
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

    bruno
    mole-cleaner
    vlc-bin

    # extracted binarys
    (binExtract android-tools "adb")
  ];

  home.sessionVariables = {
    CMAKE_INSTALL_PREFIX = "/Users/scaletto/.local_builds/";
  };
}
