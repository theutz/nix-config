{
  pkgs,
  lib,
  namespace,
  ...
} @ args: let
  name = lib.internal.path.getLastComponent ./.;

  description = "Toolkit for working with tmux and tmuxp";

  cmds = {
    edit = import ./edit.nix args;
    attach = import ./attach.nix args;
  };

  runtimeEnv = {
    TMUXP_CONFIG_DIR = "${lib.internal.vars.paths.tmuxp}";
  };

  flags = [
    "help, h, show this help"
  ];
in
  pkgs.writeShellApplication {
    inherit name;

    meta = {
      inherit description;
    };

    inherit runtimeEnv;

    runtimeInputs =
      (with pkgs; [
        bashInteractive
        gum
        tmux
        tmuxp
      ])
      ++ (lib.attrValues cmds);

    text = builtins.readFile (pkgs.replaceVars ./default.sh {
      inherit name description;

      actions = lib.pipe cmds [
        lib.attrValues
        (lib.map lib.getName)
        (lib.concatStringsSep " | ")
      ];

      help-actions = lib.pipe cmds [
        lib.attrValues
        (lib.internal.package.listToMarkdown)
      ];

      help-flags = lib.internal.package.flags.toMarkdown flags;
    });
  }
