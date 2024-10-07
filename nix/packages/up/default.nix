{
  pkgs,
  lib,
  ...
}: let
in
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
        nix fmt &&
        darwin-rebuild switch --flake .
      "
      watchexec -- "bash -c \"$cmd\""
    '';
  }
