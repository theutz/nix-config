{
  pkgs,
  lib,
  namespace,
  ...
}: let
  root = lib.${namespace}.path.getLastComponent ./.;
  name = "attach";
  description = "Start or attach to a session";
in
  pkgs.writeShellApplication {
    inherit name;

    meta = {inherit description;};

    runtimeInputs = with pkgs; [
      gum
      tmuxp
      tmux
      fzf
      yq
      bashInteractive
    ];

    runtimeEnv = {
      TMUXP_CONFIG_DIR = "${lib.${namespace}.vars.paths.tmuxp}";
    };

    text = builtins.readFile (pkgs.replaceVars ./attach.sh {
      inherit
        name
        root
        description
        ;
    });
  }
