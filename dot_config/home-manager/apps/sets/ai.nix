{
  pkgs,
  agenticTools ? false,
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    # https://github.com/tobi/qmd
    inputs.qmd.homeModules.default
  ];

  home.packages = with pkgs; [
    llama-cpp
    python314Packages.huggingface-hub # hf cli
  ];

  programs.pi-coding-agent = {
    enable = agenticTools;
    extraPackages = with pkgs; [
      nodejs
    ];

    settings = {
      defaultProvider = "llama.cpp";
      defaultModel = "LiquidAI/LFM2.5-1.2B-Thinking-GGUF:Q8_0";
      packages = [
        "npm:pi-subagents"
        "npm:pi-memory"
        "npm:@tobilu/qmd"
      ];
      retry = {
        enabled = true;
        maxRetries = 3;
      };
    };
  };

  programs.qmd = {
    enable = true;
  };

  home.activation.qmdEmbeddings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${config.programs.qmd.package}/bin:$PATH"
    qmd update
    qmd embed
  '';
}
