{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    (texliveSmall.withPackages (
      ps: with ps; [
        latexmk

        amsmath
        mathtools
        geometry
        hyperref
        cleveref
        biblatex
        biber
        csquotes
        microtype
        booktabs
        pgfplots

        luatex
      ]
    ))
  ];

  home.sessionVariables = {
    TEXMFHOME = "${config.home.homeDirectory}/.local/share/texmf";
  };
}
