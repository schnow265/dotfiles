{ masterPkgs, useLLVM ? false, ... }:
let

  llvmPkgs = with masterPkgs; [
    llvm
  ];
  gnuPkgs = with masterPkgs; [
    gcc
  ];

in {
  home.packages = [] ++ (if useLLVM then llvmPkgs else gnuPkgs);
}
