{
  config,
  lib,
  ...
}: {
  options.internal.nix.enable = lib.mkEnableOption "nix settings";

  config = lib.mkIf config.internal.nix.enable {
    nix = {
      nixPath = {
        nixpkgs = "flake:nixpkgs";
        unstable = "nixpkgs/nixpkgs-unstable";
      };

      settings = {
        auto-optimise-store = true;

        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];

        extra-experimental-features = [
          "pipe-operators"
        ];

        trusted-users = [
          "root"
          "michael"
        ];
      };
    };
  };
}
