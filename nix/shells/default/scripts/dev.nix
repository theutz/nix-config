{pkgs, ...}:
pkgs.writeShellApplication {
  name = "dev";

  meta = {
    description = "attempt to rebuild the system on each change";
  };

  runtimeInputs =
    (
      with pkgs; [
        watchexec
        noti
        bash
      ]
    )
    ++ (with pkgs.theutz; [
      flake-build
    ]);

  text = ''
    watchexec --restart --clear -- "bash -c 'noti flake-build'"
  '';
}
