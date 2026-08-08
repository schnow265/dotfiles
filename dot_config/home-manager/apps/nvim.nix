{ pkgs, ... }:

{
  home.packages = [
    pkgs.neovim
    pkgs.lua
    pkgs.luarocks
    pkgs.tree-sitter
  ];
}
