{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scal = {
      url = "github:schnow265/scaletto.nix";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      scal,
      ...
    }:
    let
      mkHome =
        {
          system,
          username,
          modules,
          extraSpecialArgs ? {}
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
          };

          modules = [
            ./homes/common.nix
            ./apps/sets/git.nix
          ]
          ++ modules;

          extraSpecialArgs = {
            inherit username system scal;
          } // extraSpecialArgs;
        };
    in
    {
      homeConfigurations = {
        "scaletto" = mkHome {
          system = "aarch64-darwin";
          username = "scaletto";
          modules = [
            ./homes/macpro.nix
            ./apps/emacs.nix
            ./apps/nvim.nix

            ./apps/dev/everything.nix
          ];
          extraSpecialArgs = {
            enableGitGui = true;
          };
        };
        "schnow265" = mkHome {
          system = "x86_64-linux";
          username = "schnow265";
          modules = [
            ./homes/steamdeck.nix
            ./apps/nvim.nix
          ];
        };
        "scal" = mkHome {
          system = "x86_64-linux";
          username = "scal";
          modules = [
            ./homes/wsl.nix
            ./apps/nvim.nix
          ];
        };
      };
    };
}
