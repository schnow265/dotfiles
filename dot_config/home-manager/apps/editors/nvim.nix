{
  pkgs,
  enableGuiTools ? false,
  ...
}:
let
  nvim_config = pkgs.fetchFromGitLab {
    owner = "schnow265";
    repo = "nvim.conf";
    rev = "3d64fa780302dbbbdaaa4c173db8963cfba0ca12";
    hash = "sha256-o4SWyarc6CcGAMD+rflg+df2opQQb2ymAGqzZoTGryE=";
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
