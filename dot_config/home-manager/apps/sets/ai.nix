{
  pkgs,
  agenticTools ? false,
  ...
}:
{
  home.packages = with pkgs; [
    llama-cpp
  ] ++ lib.optionals agenticTools [
    pi-coding-agent
  ];
}
