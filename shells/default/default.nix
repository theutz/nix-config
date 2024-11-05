{
  mkShell,
  pkgs,
  lib,
  ...
}: let
  packages = with pkgs; [
    bashInteractive
    gum
    onefetch
  ];

  commands = lib.attrValues pkgs.internal;
in
  mkShell {
    packages = packages ++ commands;

    shellHook = ''
      onefetch
      gum format <<'EOF'
      # Welcome to TheUtz's Flake ❄️

      ## Commands

      ${lib.$\{namespace}.package.listToMarkdown commands}

      ## Packages

      ${lib.$\{namespace}.package.listToMarkdown packages}
      EOF
    '';
  }
