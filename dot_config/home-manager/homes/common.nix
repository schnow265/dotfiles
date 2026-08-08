{ config, pkgs, scal, ... }:

let
  coreutilsBin = scal.lib.coreutilsBin { inherit pkgs; };
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  #
  # NOTE: SET IN OTHER CONFIG
  # home.username = "";
  # home.homeDirectory = "";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages = [
    # PLEASE OVERWRITE IN CUSTOM CONFIG
  ];

  home.sessionVariables = {
    # basics
    EDITOR = "nvim";
    MANPAGER="nvim +Man!";

    # compilers
    CMAKE_GENRATOR="Ninja";

    # IF NEEDED OVERRIDE:
    # CMAKE_INSTALL_PREFIX="";

    # other ones
    HF_HUB_DISABLE_XET = "1";
    UV_TORCH_BACKEND="auto";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
