{
  mkShell,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.internal.pacakge) listToMarkdown;

  guide = pkgs.writeShellApplication {
    name = "guide";
    meta.description = "show this guide";
    runtimeInputs = with pkgs; [gum onefetch];
    text = pkgs.replaceVars ./guide.sh {
      commands = listToMarkdown commands;
      packages = listToMarkdown packages;
    };
  };

  commands = lib.concatLists [
    guide
    (lib.attrValues pkgs.internal)
  ];

  packages = with pkgs; [
    gum
    bashInteractive
  ];

  shellHook = builtins.readFile (pkgs.replaceVars ./hook.sh {
    help = lib.getName guide;
  });
in
  mkShell {
    packages = packages ++ commands;

    inherit shellHook;
  }
