{
  config,
  lib,
  pkgs,
  inputs,
  aiAdditions ? false,
  ...
}:
{
  imports = [
    # https://github.com/tobi/qmd
    inputs.qmd.homeModules.default
  ];

  programs.zk = {
    enable = true;
    settings = {
      note = {
        default-title = "Untitled";
        extension = "md";
        filename = "{{format-date now '%Y'}}/{{format-date now '%m'}}/{{format-date now '%d'}}/{{id}}";
        id-case = "lower";
        id-charset = "hex";
        id-length = 6;
      };
      notebook.dir = "${config.home.homeDirectory}/zk/";
    };
    exportNotebookDir = true;
  };

  home.activation.zkIndex = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${pkgs.zk}/bin:$PATH"
    zk index $VERBOSE_ARG
  '';

  programs.qmd = {
    enable = aiAdditions;
  };

  home.activation.qmdEmbeddings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${config.programs.qmd.package}/bin:$PATH"
    qmd update
    qmd embed
  '';
}
