{
  config,
  lib,
  ...
}: {
  options.internal.nix.enable = lib.mkEnableOption "nix settings";

  config = lib.mkIf config.internal.nix.enable {
    nix = {
      checkConfig = true;

      optimise = {
        automatic = true;
        interval = [
          {
            Hour = 4;
            Minute = 15;
            Weekday = 7;
          }
        ];
        user = "michael";
      };

      gc = {
        automatic = true;
        user = "michael";
        interval = [
          {
            Hour = 4;
            Minute = 15;
            Weekday = 7;
          }
        ];
      };

      nixPath = {
        nixpkgs = "flake:nixpkgs";
        unstable = "nixpkgs/nixpkgs-unstable";
      };

      settings = {
        accept-flake-config = true;

        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];

        trusted-users = [
          "root"
          "michael"
        ];
      };
    };

    services.nix-daemon = {
      enable = true;
    };
  };
}
