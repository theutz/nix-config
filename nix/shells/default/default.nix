{
  mkShell,
  pkgs,
  lib,
  ...
} @ inputs: let
  scripts =
    lib.forEach
    (lib.filesystem.listFilesRecursive ./scripts)
    (f: import f inputs);

  commands =
    scripts
    ++ (with pkgs.theutz; [
      print-path-to-flake
      mkHomeModule
    ]);
in
  mkShell rec {
    packages =
      (with pkgs; [
        gum
      ])
      ++ commands;

    shellHook = ''
      gum format <<'EOF'
      # Welcome to TheUtz's Flake ❄️

      ## Commands

      ${lib.theutz.package.listToMarkdown packages}
      EOF
    '';
  }
