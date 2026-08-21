{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clang
    cmake
    ninja
    ccache
    meson
  ];

  home.sessionVariables = {
    CMAKE_GENRATOR="Ninja";
    # IF NEEDED OVERRIDE:
    # CMAKE_INSTALL_PREFIX="";
  };
}
