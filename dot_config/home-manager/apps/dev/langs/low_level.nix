{ pkgs, useLLVM ? false, ... }:
let

  llvmPkgs = with pkgs; [
    llvm
  ];
  gnuPkgs = with pkgs; [
    gcc
  ];

in {
  home.packages = [] ++ (if useLLVM then llvmPkgs else gnuPkgs);
}
