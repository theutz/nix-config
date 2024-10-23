{
  mkShell,
  pkgs,
  lib,
  ...
}: let
  packages = with pkgs; [
    gum
  ];

  commands = with pkgs.theutz; [
    flake-build
    flake-dev
    flake-edit
    mkHomeModule
    mkPackage
    mkTmuxpSession
    print-path-to-flake
    print-path-to-home-modules
  ];
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
