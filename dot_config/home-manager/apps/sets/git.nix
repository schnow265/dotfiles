{
  pkgs,
  enableGuiTools ? false,
  masterPkgs,
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
      git-bug
    ]
    ++ lib.optionals enableGuiTools [
      (masterPkgs.sourcegit.overrideAttrs (oldAttrs: {
        runtimeDeps = (oldAttrs.runtimeDeps or [ ]) ++ [
          git-lfs
        ];
      }))
    ];
}
