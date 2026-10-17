{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    fd
    ripgrep
    ktlint
    plantuml
    graphviz
    shellcheck
    fontconfig
  ];

  home.file = {
    ".config/emacs".source = inputs.chemacs2_git;
    ".local/share/external/emacs-cfg/spacemacs".source = inputs.spacemacs_git;

    ".emacs-profile".text = ''
      spacemacs
    '';
    ".config/chemacs/profiles.el".text = ''
      (
        ("spacemacs" . ((user-emacs-directory . "~/.local/share/external/emacs-cfg/spacemacs")))
      )
    '';
  };

  programs.emacs = {
    enable = true;
  };
}
