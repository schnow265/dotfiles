{
  pkgs,
  enableGuiTools ? false,
  ...
}:
let
  nvim_config = pkgs.fetchFromGitLab {
    owner = "schnow265";
    repo = "nvim.conf";
    rev = "f0b6625d5d00e72de08bda31d0ae3d206a82a767";
    hash = "sha256-Ub0UggywS/tHLxQK0ZYUsJIwKpmHiJHv8z9WxbFC5ZM=";
  };
in
{
  home.file.".config/nvim".source = nvim_config;

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
