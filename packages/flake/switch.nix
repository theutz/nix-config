{
  pkgs,
  main,
  lib,
  ...
}:
pkgs.writeShellApplication rec {
  name = "switch";

  meta = {
    description = "Build, activate, commit, and push";
  };

  runtimeInputs = with pkgs; [
    gum
  ];

  text = builtins.readFile (pkgs.replaceVars ./switch.sh {
    inherit main name;
    inherit (meta) description;
    inherit (lib.internal.bash) loggers;
  });
}
