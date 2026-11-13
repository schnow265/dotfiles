{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    borgbackup
    ffmpeg

    mole-cleaner
  ];

  home.sessionVariables = {
    CMAKE_INSTALL_PREFIX = "/Users/scaletto/.local_builds/";
    HF_HUB_CACHE = "/Users/scaletto/LLama";
    CC = "/usr/bin/clang";
    CXX = "/usr/bin/clang++";
    HOMEBREW_CASK_OPTS = "--appdir='/Users/scaletto/Applications/Homebrew'";
  };

  home.file = {
    ".config/mole/whitelist".text = ''
      ~/.cache/huggingface/*
      ~/Library/Application Support/JetBrains*
      ~/LLama/*
    '';
  };
}
