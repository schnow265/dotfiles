{
  lib,
  scal,
  pkgs,
  username,
  system,
  enableGuiTools ? false,
  ...
}:
let
  binExtract = scal.lib.binExtract { inherit pkgs; };

  path = if lib.hasSuffix "-darwin" system then "/Users" else "/home";

  nixos-zsh-completions = pkgs.fetchFromGitHub {
    owner = "nix-community";
    repo = "nix-zsh-completions";
    rev = "d4ae06bedb9a353ac894862d1d83f60ab4e2ccce";
    hash = "sha256-ogDhANf4MpVZn5sWZymT0EIjDMTLSHRGzNjHsw/dX8o=";
  };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  #
  # Paths set automagically
  home.username = username;
  home.homeDirectory = "${path}/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages =
    with pkgs;
    [
      aria2
      bat
      btop
      chezmoi
      delta
      devenv
      direnv
      fastfetch
      lsd
      ripgrep
      tlrc
      topgrade
    ]
    ++ (if enableGuiTools then [ keepassxc ] else [ (binExtract pkgs.keepassxc "keepassxc-cli") ]);

  home.sessionVariables = {
    # other ones
    HF_HUB_DISABLE_XET = "1";
    UV_TORCH_BACKEND = "auto";
  };

  home.file = {
    ".local/share/external/zsh/nixos-completions".source = nixos-zsh-completions;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
