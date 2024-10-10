{
  mkShell,
  pkgs,
  lib,
  ...
}: let
  utzvim = pkgs.writeShellApplication {
    name = "utzvim";

    runtimeInputs = [
      pkgs.gum
    ];

    text = ''
      while :; do
        nix run .#utzvim -- -c 'cd nix/packages/utzvim'
        if ! gum confirm "Restart?" --timeout=5s; then
          exit
        fi
      done
    '';
  };

  up = pkgs.writeShellApplication {
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
  };
in
  mkShell {
    packages = with pkgs; [
      gum
      up
      utzvim
    ];

    shellHook = ''
      gum format <<EOF
      # Welcome to TheUtz's Flake

      ## Commands

      - \`up\`: start the dev server
      - \`utzvim\`: edit vim config
      EOF
    '';
  }
