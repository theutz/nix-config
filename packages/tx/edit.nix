{
  pkgs,
  namespace,
  lib,
  ...
}: let
  root = lib.internal.path.getLastComponent ./.;
  name = "edit";
  description = "Edit the tmuxp session file";
  flags = [
    "help, h, show this help"
  ];
in
  pkgs.writeShellApplication {
    inherit name;

    meta = {inherit description;};

    runtimeInputs = with pkgs; [
      fzf
      tmux
      tmuxp
      gum
    ];

    text = builtins.readFile (pkgs.replaceVars ./edit.sh {
      inherit
        root
        name
        description
        ;

      help-flags = lib.internal.package.flags.toMarkdown flags;
    });
  }
