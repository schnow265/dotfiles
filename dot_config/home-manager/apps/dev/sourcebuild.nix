{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clang
    cmake
    ninja
    ccache
    meson
  ];
}
