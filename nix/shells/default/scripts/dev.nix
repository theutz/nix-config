{pkgs, ...}:
pkgs.writeShellApplication {
  name = "dev";

  meta = {
    description = "attempt to rebuild the system on each change";
  };

  runtimeInputs = with pkgs; [
    git
    watchexec
    noti
  ];

  text = ''
    cmd="
      git add -A &&
        darwin-rebuild switch --flake .
    "
    watchexec --restart --clear -- "bash -c \"$cmd\""
  '';
}
