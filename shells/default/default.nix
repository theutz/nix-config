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

  commands = with lib;
    pkgs.internal
      |> traceVal
      |> filter (p: p.meta.mainProgram != "nvim")
      |> attrValues;
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
