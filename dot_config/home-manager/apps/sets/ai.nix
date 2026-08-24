{
  pkgs,
  agenticTools ? false,
  ...
}:
{
  home.packages = with pkgs; [
    llama-cpp
    python314Packages.huggingface-hub # hf cli
  ] ++ lib.optionals agenticTools [
    pi-coding-agent
    nodejs # pi plugins run by npm
  ];
}
