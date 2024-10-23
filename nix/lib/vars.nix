{lib, ...}: let
  inherit (lib.path.subpath) join normalise;
  inherit (lib.strings) removePrefix;
  mk = paths: removePrefix "./" (normalise (join paths));
in {
  paths = rec {
    flake = "nix-config";
    flakeRoot = mk [flake "nix"];
    homeModules = mk [flakeRoot "modules" "home"];
    tmux = mk [homeModules "tmux"];
    tmuxp = mk [tmux "tmuxp" "sessions"];
  };
}
