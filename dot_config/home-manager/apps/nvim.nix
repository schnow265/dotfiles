{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim

    lua
    luarocks
    tree-sitter
    git
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER="nvim +Man!";
  };
}
