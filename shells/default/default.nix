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

  commands = lib.pipe pkgs.internal [
    lib.attrValues
    (lib.filter (pkg: lib.getName pkg != "nixvim"))
  ];
in
  mkShell {
    packages = packages ++ commands;

    shellHook = ''
      onefetch
      gum format <<'EOF'
      # Welcome to TheUtz's Flake ❄️

      ## Commands

      ${lib.internal.package.listToMarkdown commands}

      ## Packages

      ${lib.internal.package.listToMarkdown packages}
      EOF
    '';
  }
