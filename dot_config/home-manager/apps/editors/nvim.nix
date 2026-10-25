{
  pkgs,
  enableGuiTools ? false,
  inputs,
  config,
  ...
}:
{
  home.file.".config/nvim".source = inputs.nvimConfig;

  home.packages = with pkgs; [
    nvimpager
  ];

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
      lua5_1
      wget
      fd
      ripgrep

      # mason.nvim package managers
      go
      cargo
      nodejs
      ruby
    ];
  };

  programs.neovide = {
    enable = enableGuiTools;

    settings = {
      fork = true;
      neovim-bin = "${config.programs.neovim.finalPackage}/bin/nvim";
    };
  };

  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
    PAGER = "nvimpager";
  };
}
