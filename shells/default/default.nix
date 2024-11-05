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

  commands = lib.attrValues pkgs.theutz;
in
  mkShell {
    packages = packages ++ commands;

    shellHook = ''
      onefetch
      gum format <<'EOF'
      # Welcome to TheUtz's Flake ❄️

      ## Commands

      ${lib.theutz.package.listToMarkdown commands}

      ## Packages

      ${lib.theutz.package.listToMarkdown packages}
      EOF
    '';
  }
