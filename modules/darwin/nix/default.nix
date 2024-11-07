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
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operator"
        ];

        trusted-users = [
          "root"
          "michael"
        ];
      };
    };
  };
}
