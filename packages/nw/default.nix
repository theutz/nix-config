{
  lib,
  pkgs,
  ...
}: let
in
  pkgs.writeShellApplication rec {
    name = lib.pipe ./. (with lib; [
      path.splitRoot
      (getAttr "subpath")
      path.subpath.components
      last
    ]);

    meta.description = "Nix cli wrapper";

    runtimeInputs = with pkgs; [
      fzf
      gum
      jq
      unixtools.column
    ];

    text = builtins.readFile (pkgs.replaceVars ./default.sh {
      inherit (lib.internal.bash) loggers;
      inherit name;
      inherit (meta) description;
    });
  }
