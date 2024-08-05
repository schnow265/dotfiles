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
	  automake
          bc
          binutils
          bison
	  bzip2
          dwarfs
	  elfutils
          flex
          gcc
	  gawk
          git
          gnupg24
	  gnumake
	  gnupatch
	  gperf
          gzip
	  help2man
          libelf
	  libgcc
	  libtool
	  meson
          ncurses5
	  ninja
          openssl.dev
          openssl
          pahole
          perl
	  python3
          rsync
	  stdenv.cc.cc.lib
	  texinfo
	  unzip
          gnutar
	  wget
          xz
          zlib

        ];
      };
    };
}
