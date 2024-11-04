{
  pkgs,
  switch,
  ...
}:
pkgs.writeShellApplication {
  name = "watch";

  meta.description = "Watch for changes and reload.";

  runtimeInputs =
    [switch]
    ++ (with pkgs; [
      watchexec
    ]);

  text = ''
    cd "$MY_FLAKE_DIR"
    watchexec --clear --restart --notify -- switch
  '';
}
