{
  description = "theutz: a flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "unstable";
    };

    nixvim = {
      url = "github:theutz/nixvim";
      inputs.nixpkgs.follows = "unstable";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
    };

    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    Neve = {
      url = "github:theutz/Neve";
    };
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;

      snowfall = {
        root = ./nix;
        namespace = "theutz";
        meta = {
          name = "theutz";
          title = "TheUtz: A Flake";
        };
      };
    };
  in
    lib.mkFlake {
      overlays = with inputs; [
        snowfall-flake.overlays.default
      ];

      homes.modules = with inputs; [
        nix-index-database.hmModules.nix-index
      ];

      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };
    };
}
