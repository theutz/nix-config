{
  mkShell,
  pkgs,
  ...
}: let
  utzvim = pkgs.writeShellApplication {
    name = "utzvim";
    text = "while :; do nix run .#utzvim; done";
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
