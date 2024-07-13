{
  description = "A little flake to have fun with C code.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShell.${system} = pkgs.mkShell {
        buildInputs = with pkgs; [
          autoconf
          bc
          binutils
          bison
          dwarfs
	        elfutils
          flex
          gcc
          git
          gnupg24
          gzip
          libelf
          ncurses5
          openssl.dev
          openssl
          pahole
          perl
          rsync
          gnutar
          xz
	        zlib
        ];
      };
    };
}
