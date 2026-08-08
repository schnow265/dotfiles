{ config, pkgs, scal, ... }:

let
  coreutilsBin = scal.lib.coreutilsBin { inherit pkgs; };
in {
  home.username = "schnow265";
  home.homeDirectory = "/home/schnow265";

  home.packages = [
    # PLEASE OVERWRITE IN CUSTOM CONFIG
  ];

  home.sessionVariables = {
  };
}
