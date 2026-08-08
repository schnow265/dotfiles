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
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHome =
        {
          system,
          username,
          modules,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
          };

          modules = [
            ./homes/common.nix
          ]
          ++ modules;

          extraSpecialArgs = {
            inherit username system;
          };
        };
    in
    {
      homeConfigurations = {
        "scaletto" = mkHome {
          system = "aarch64-darwin";
          username = "scaletto";
          modules = [
            ./homes/macpro.nix
          ];
        };
        "schnow265" = mkHome {
          system = "x86_64-linux";
          username = "schnow265";
          modules = [
            ./homes/steamdeck.nix
          ];
        };
      };
    };
}
