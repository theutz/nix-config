{
  nix = {
    nixPath = {
      nixpkgs = "flake:nixpkgs";
      darwin-config = "/etc/darwin-config";
      unstable = "github:nixpkgs/nixpkgs-unstable";
    };

    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "michael"];
    };
  };
}
