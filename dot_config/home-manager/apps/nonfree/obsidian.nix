{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    obsidian
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "obsidian"
    ];
}
