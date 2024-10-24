{lib, ...}: let
  mkPath = with lib;
    (flip pipe) [
      path.subpath.join
      (removePrefix "./")
    ];
in {
  paths = rec {
    flake = "nix-config";
    flakeRoot = mkPath [flake "nix"];
    modules = mkPath [flakeRoot "modules"];
    homeModules = mkPath [modules "home"];
    darwinModules = mkPath [modules "darwin"];
    tmux = mkPath [homeModules "tmux"];
    tmuxp = mkPath [tmux "tmuxp" "sessions"];
  };
}
