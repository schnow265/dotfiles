{
  pkgs,
  enableGitGui ? false,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      git
      delta
      gh
      git
      git-lfs
      git-xet
      glab
      lazygit
    ]
    ++ lib.optionals enableGitGui [
      (sourcegit.overrideAttrs (oldAttrs: {
        runtimeDeps = (oldAttrs.runtimeDeps or [ ]) ++ [
          git-lfs
        ];
      }))
    ];
}
