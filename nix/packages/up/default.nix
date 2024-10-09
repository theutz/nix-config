{
  pkgs,
  lib,
  ...
}: let
  name = lib.theutz.getLastComponent ./.;
in
  pkgs.writeShellApplication {
    inherit name;

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
