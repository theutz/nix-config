{
  mkShell,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.internal.package) listToMarkdown;

  guide = pkgs.writeShellApplication {
    name = "guide";
    meta.description = "Show this guide";
    runtimeInputs = with pkgs; [
      gum
      onefetch
      less
    ];
    text = builtins.readFile (pkgs.replaceVars ./guide.sh {
      commands = listToMarkdown commands;
      packages = listToMarkdown packages;
    });
  };

  commands = [
    guide
    (
      pkgs.writeShellApplication {
        name = "reload";
        meta.description = "Reload shell environment";
        runtimeInputs = with pkgs; [direnv];
        text = ''
          direnv reload || direnv allow
        '';
      }
    )
  ];

  packages =
    (lib.attrValues pkgs.internal)
    ++ (with pkgs; [
      gum
      bashInteractive
    ]);

  shellHook = builtins.readFile (pkgs.replaceVars ./hook.sh {
    help = lib.getName guide;
  });
in
  mkShell {
    packages = packages ++ commands;

    inherit shellHook;
  }
