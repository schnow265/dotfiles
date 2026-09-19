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
        let
          masterPkgs = nixmaster.legacyPackages.${system};
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
          };

          modules = [
            ./homes/common.nix
            ./apps/sets/git.nix
            ./apps/nvim.nix
          ]
          ++ modules;

          extraSpecialArgs = {
            enableGuiTools = false;
            agenticTools = false;
            useLLVM = false; # provides llvm / gcc when apps/dev/langs/low_level.nix is included.
            advancedTools = false;

            inherit username system scal masterPkgs;
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

            ./apps/dev/everything.nix
            ./apps/sets/ai.nix
          ];
          extraSpecialArgs = {
            enableGuiTools = true;
            agenticTools = false;
          };
        };
        "schnow265" = mkHome {
          system = "x86_64-linux";
          username = "schnow265";
          modules = [
            ./homes/steamdeck.nix
          ];

          extraSpecialArgs = {
            enableGuiTools = true;
          };
        };
        # "lite" user profile.
        "scal" = mkHome {
          system = "x86_64-linux";
          username = "scal";
          modules = [
            ./homes/lite.nix
          ];
          extraSpecialArgs = {};
        };
      };
    };
}
