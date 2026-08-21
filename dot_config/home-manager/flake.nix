{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixmaster.url = "github:nixos/nixpkgs";
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
      nixmaster,
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

        masterPkgsDarwin = nixmaster.legacyPackages.aarch64-darwin;
        masterPkgsLinux = nixmaster.legacyPackages.x86_64-linux;
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
            ./apps/sets/ai.nix
          ];
          extraSpecialArgs = {
            enableGuiTools = true;
            agenticTools = true;
            inherit masterPkgsDarwin;
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
        # "lite" user profile.
        "scal" = mkHome {
          system = "x86_64-linux";
          username = "scal";
          modules = [
            ./homes/lite.nix
            ./apps/nvim.nix
          ];
        };
      };
    };
}
