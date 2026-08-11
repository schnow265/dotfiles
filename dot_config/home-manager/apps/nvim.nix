{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim

    lua
    luarocks
    tree-sitter
    git
  ];
}
