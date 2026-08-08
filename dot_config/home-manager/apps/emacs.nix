{pkgs, ...}:

{
  home.packages = [
    pkgs.emacs

    pkgs.fd
    pkgs.ripgrep
    pkgs.ktlint
    pkgs.plantuml
    pkgs.graphviz
    pkgs.shellcheck
    pkgs.fontconfig
  ];
}
