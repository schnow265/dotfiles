{
  description = "A little flake to have fun with the kernel.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShell.${system} = pkgs.mkShell {
        buildInputs = [
          pkgs.bc
          pkgs.binutils
          pkgs.bison
          pkgs.dwarfs
	  pkgs.elfutils
          pkgs.flex
          pkgs.gcc
          pkgs.git
          pkgs.gnupg24
          pkgs.gzip
          pkgs.libelf
          pkgs.ncurses5
          pkgs.openssl.dev
          pkgs.openssl
          pkgs.pahole
          pkgs.perl
          pkgs.rsync
          pkgs.gnutar
          pkgs.xz
	  pkgs.zlib
        ];
      };
    };
}
