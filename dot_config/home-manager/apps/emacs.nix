{pkgs, ...}:

{
  home.packages = with pkgs; [
    emacs

    fd
    ripgrep
    ktlint
    plantuml
    graphviz
    shellcheck
    fontconfig
  ];
}
