{
  pkgs,
  ...
}:
let
  kaktree = pkgs.fetchFromGitHub {
    owner = "andreyorst";
    repo = "kaktree";
    rev = "320d0a339638452e79be2a9caef11c05e8d47bec";
    hash = "sha256-67MpqTI6thQxFezYUHC2nETa1honfm2BQhqC+bsmQtQ=";
  };
in
{
  programs.kakoune = {
    enable = true;
    plugins = with pkgs.kakounePlugins; [
      kakboard
      kakoune-lsp
      rep
      auto-pairs-kak
      powerline-kak
      kakoune-catppuccin
      tabs-kak
      fzf-kak
    ];
  };

  home.file = {
    ".config/kak/autoload/kaktree".source = kaktree;
  };
}
