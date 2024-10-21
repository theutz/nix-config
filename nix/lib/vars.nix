{lib, ...}: let
  inherit (lib.path.subpath) join;
in {
  paths = rec {
    flake = "nix-config";
    flakeRoot = join [flake "nix"];
    homeModules = join [flakeRoot "modules" "home"];
    tmux = join [homeModules "tmux"];
    tmuxp = join [tmux "sessions"];
  };
}
