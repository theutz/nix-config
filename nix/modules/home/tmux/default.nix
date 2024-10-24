{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  mod = lib.pipe ./. [
    lib.path.splitRoot
    (lib.getAttr "subpath")
    lib.path.subpath.components
    lib.last
  ];
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption mod;
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      programs.tmux = {
        enable = true;
        plugins = with pkgs.tmuxPlugins; [
          sessionist
          pain-control
          yank
        ];
        escapeTime = 0;
        mouse = true;
        keyMode = "vi";
        prefix = "C-b";
        resizeAmount = 5;

        tmuxp.enable = true;

        extraConfig = lib.concatStringsSep "\n" [
          (builtins.readFile ./tmux.conf)
          ''
            set -gu default-command
          ''
        ];
      };
    }
    (lib.mkIf config.programs.tmux.tmuxp.enable {
      home.packages = with pkgs.theutz; [
        tmuxp-attach
        tmuxp-edit
      ];

      xdg.configFile."tmuxp" = {
        enable = true;
        recursive = true;
        source = ./tmuxp/sessions;
      };
    })
  ]);
}
