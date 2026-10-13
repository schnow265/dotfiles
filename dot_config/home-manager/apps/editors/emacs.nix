{
  pkgs,
  ...
}:
let
  chemacs2_git = pkgs.fetchFromGitHub {
    owner = "plexus";
    repo = "chemacs2";
    rev = "c2d700b784c793cc82131ef86323801b8d6e67bb";
    hash = "sha256-/WtacZPr45lurS0hv+W8UGzsXY3RujkU5oGGGqjqG0Q=";
  };

  spacemacs_git = pkgs.fetchFromGitHub {
    owner = "syl20bnr";
    repo = "spacemacs";
    rev = "551b6666bfaf7c5f67411879327d71ebae6ed4bb";
    hash = "sha256-UQ+2BsYUtEehw6diEJeWud8JXcmUe592RBsEABjEeNU=";
  };
in
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
    ".config/emacs".source = chemacs2_git;
    ".local/share/external/emacs-cfg/spacemacs".source = spacemacs_git;

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
