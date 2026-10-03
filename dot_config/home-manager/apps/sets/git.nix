{
  pkgs,
  enableGuiTools ? false,
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
      (sourcegit.overrideAttrs (oldAttrs: {
        runtimeDeps = (oldAttrs.runtimeDeps or [ ]) ++ [
          git-lfs
        ];
      }))
    ];
}
