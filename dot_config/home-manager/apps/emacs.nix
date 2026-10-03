{pkgs, ...}:

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

  programs.emacs = {
    enable = true;
  };
}
