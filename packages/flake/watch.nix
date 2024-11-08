{
  pkgs,
  lib,
  switch,
  main,
  ...
}:
pkgs.writeShellApplication rec {
  name = "watch";

  meta.description = "Watch for changes and reload.";

  runtimeInputs =
    [
      switch
    ]
    ++ (with pkgs; [
      watchexec
      gum
    ]);

  text = builtins.readFile (pkgs.replaceVars ./watch.sh {
    inherit (meta) description;
    inherit (lib.internal.bash) loggers;
    cmd = "${main} ${name}";
  });
}
