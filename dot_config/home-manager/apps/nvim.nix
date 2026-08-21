{
  pkgs,
  enableGuiTools ? false,
  ...
}:

{
  home.packages = with pkgs; [
    neovim

    lua
    luarocks
    tree-sitter
    git
  ] ++ lib.optionals enableGuiTools [
    neovide
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };
}
