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
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = inputs:
      inputs.snowfall-lib.mkFlake {
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

        overlays = with inputs; [
          snowfall-flake.overlays.default
        ];
      };
}
