{
  pkgs,
  enableGuiTools ? false,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      delta
      git
      git-bug
      git-lfs
      git-xet
      lazygit
    ]
    ++ lib.optionals enableGuiTools [
      (sourcegit.overrideAttrs (oldAttrs: {
        runtimeDeps = (oldAttrs.runtimeDeps or [ ]) ++ [
          git-lfs
        ];
      }))
    ];
}
