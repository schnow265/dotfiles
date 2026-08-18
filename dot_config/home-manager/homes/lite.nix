{ config, pkgs, ... }:

{
  home.username = "scal";
  home.homeDirectory = "/home/scal";

  home.sessionVariables = {
    #HF_HUB_DISABLE_XET = "0";
  };
}
