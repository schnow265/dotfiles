{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # third party flakes
    qmd = {
      url = "github:tobi/qmd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # my own stuff
    scal.url = "github:schnow265/scaletto.nix";

    # sources from git
    nvimConfig = {
      url = "gitlab:schnow265/nvim.conf";
      flake = false;
    };

    nixZshCompletions = {
      url = "github:nix-community/nix-zsh-completions";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      mkHome =
        {
          system,
          username,
          modules,
          extraSpecialArgs ? { },
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
          };

          modules = [
            ./homes/common.nix
            ./apps/sets/git.nix
            ./apps/editors/nvim.nix
            ./apps/dev/mise.nix
            ./apps/sets/shell_tools.nix
          ]
          ++ modules;

          extraSpecialArgs = {
            enableGuiTools = false;
            agenticTools = false;
            useLLVM = false; # provides llvm / gcc when apps/dev/langs/low_level.nix is included.
            advancedTools = false;
            enableMiseInstall = true;
            aiAdditions = false; # funny haha ai stuff.

            inherit
              inputs
              username
              system
              ;
          }
          // extraSpecialArgs;
        };
    in
    {
      homeConfigurations = {
        "scaletto" = mkHome {
          system = "aarch64-darwin";
          username = "scaletto";
          modules = [
            ./homes/macpro.nix

            ./apps/sets/ai.nix
            ./apps/sets/markdown.nix

            ./apps/editors/zed.nix

            ./apps/dev/langs/nix.nix

            ./apps/nonfree/obsidian.nix
          ];
          extraSpecialArgs = {
            enableGuiTools = true;
            agenticTools = false;
            aiAdditions = true;
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
          extraSpecialArgs = { };
        };
        # the aarch64-linux one
        "sn0w" = mkHome {
          system = "aarch64-linux";
          username = "sn0w";
          modules = [
          ];
          extraSpecialArgs = {
            enableMiseInstall = false;
          };
        };
      };
    };
}
