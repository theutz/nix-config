{
  mkShell,
  pkgs,
  lib,
  ...
}: let
  packages = with pkgs; [
    bashInteractive
    gum
  ];

  commands = lib.attrValues pkgs.theutz;
in
  mkShell {
    packages = packages ++ commands;

    shellHook = ''
      gum format <<'EOF'
      # Welcome to TheUtz's Flake ❄️

      ## Commands

      ${lib.theutz.package.listToMarkdown commands}

      ## Packages

      ${lib.theutz.package.listToMarkdown packages}
      EOF
    '';
  }
