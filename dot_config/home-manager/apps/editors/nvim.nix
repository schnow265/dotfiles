{
  pkgs,
  enableGuiTools ? false,
  ...
}:
let
  nvim_config = pkgs.fetchFromGitLab {
    owner = "schnow265";
    repo = "nvim.conf";
    rev = "28c6c40634724d8854a1078b76190c0dae1acbed";
    hash = "sha256-XxLuX9SiJWA/B6q4sU4yaFuQbML84iIeBwnCXjWDsJQ=";
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
