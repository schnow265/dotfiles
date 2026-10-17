{
  pkgs,
  inputs,
  ...
}:
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
    ".config/kak/autoload/kaktree".source = inputs.kakoune_kaktree;
  };
}
