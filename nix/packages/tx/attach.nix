{
  pkgs,
  lib,
  namespace,
  ...
}: let
  root = lib.${namespace}.path.getLastComponent ./.;
  name = "attach";
  description = "Start or attach to a session";
  flags = [
    "help, h, show this help"
  ];
  pipe' = lib.flip lib.pipe;
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
      inherit description;

      cmd = "${root} ${name}";
      flags = lib.pipe flags [
        (lib.map (pipe' [
          (lib.splitString ", ")
          (flag: let
            at = (lib.elemAt) flag;
          in "| --${at 0} | -${at 1} | ${at 2} |")
        ]))
      ];
    });
  }
