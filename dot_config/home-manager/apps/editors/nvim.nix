{
  pkgs,
  enableGuiTools ? false,
  ...
}:

{
  programs.neovim  = {
    enable = true;
    defaultEditor = true;
    autowrapRuntimeDeps = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    sideloadInitLua = true;

    extraPackages = with pkgs; [
      tree-sitter
      git
      luarocks
    ];
  };

  programs.neovide = {
    enable = enableGuiTools;

    settings = {
      fork = true;
      neovim-bin = "${pkgs.neovim}/bin/nvim";
    };
  };

  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
  };
}
