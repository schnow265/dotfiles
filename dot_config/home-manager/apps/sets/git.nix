{pkgs, ...}:
{
  home.packages = with pkgs; [
    git
    delta
    gh
    git
    git-lfs
    git-xet
    glab
    lazygit
  ];
}
