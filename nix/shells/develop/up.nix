{pkgs, ...}:
pkgs.writeShellApplication {
  name = "up";

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
    watchexec -- "bash -c \"$cmd\""
  '';
}
