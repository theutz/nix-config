{
  pkgs,
  lib,
  ...
}: {
  plugins.lint = {
    enable = true;
    lintersByFt = {
      nix = ["deadnix" "nix"];
    };
  };
}
