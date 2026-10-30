{
  pkgs,
  agenticTools ? false,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  home.packages = with pkgs; [
    llama-cpp
    python314Packages.huggingface-hub # hf cli
  ] ++ lib.optionals isDarwin [
    python314Packages.mlx-lm
  ];

  programs.pi-coding-agent = {
    enable = agenticTools;
    extraPackages = with pkgs; [
      nodejs
    ];

    mutableSettings = true;

    settings = {
      defaultProvider = "llama.cpp";
      defaultModel = "LiquidAI/LFM2.5-1.2B-Thinking-GGUF:Q8_0";
      packages = [
        "npm:pi-subagents"
        "npm:pi-memory" # qmd lies in sets/markdown
      ];
      retry = {
        enabled = true;
        maxRetries = 3;
      };
    };
  };
}
