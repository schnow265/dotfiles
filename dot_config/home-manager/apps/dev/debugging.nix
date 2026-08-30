{
  pkgs,
  advancedTools ? false,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    gdb
    lldb
  ] ++ lib.optionals advancedTools [
    ghidra
    ghidra-extensions.machinelearning
    ghidra-extensions.ghidra-firmware-utils
    ghidra-extensions.gnudisassembler
    ghidra-extensions.findcrypt
    ghidra-extensions.lightkeeper
    ghidra-extensions.ret-sync
  ];
}
