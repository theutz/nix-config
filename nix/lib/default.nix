{lib, ...}: let
  inherit (lib.path.subpath) join;
  modFns = import ./modules.nix {inherit lib;};
in
  lib.mergeAttrsList [modFns]
  // {
    vars = {
      paths = rec {
        flake = "nix-config";
        flakeRoot = join [flake "nix"];
        homeModules = join [flakeRoot "modules" "home"];
        tmux = join [homeModules "tmux"];
        tmuxp = join [tmux "sessions"];
      };
    };
  }
