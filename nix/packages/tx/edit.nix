{
  pkgs,
  namespace,
  lib,
  ...
}: let
  root = lib.${namespace}.path.getLastComponent ./.;
  name = "edit";
  description = "Edit the tmuxp session file";
  flags = [
    {
      long = "help";
      short = "h";
      desc = "show this help";
    }
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

      flags = lib.forEach flags ({
        long,
        short,
        desc,
      }: ''
        | --${long} | -${short} | ${desc} |
      '');
    });
  }
