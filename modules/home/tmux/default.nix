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
    lib.lists.last
  ];

  cfg = config.internal.${mod};

  inherit (lib.home-manager) hm;
in {
  options.internal.${mod} = {
    enable = lib.mkEnableOption mod;
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.activation.reloadTmux =
        hm.dag.entryAfter ["writeBoundary"]
        /*
        bash
        */
        ''
          tmux="${lib.getExe pkgs.tmux}"
          conf_file="${lib.concatStringsSep "/" [
            config.xdg.configHome
            "tmux"
            "tmux.conf"
          ]}"
          echo "Reloading tmux config..."
          if "$tmux" source-file "$conf_file"; then
            echo "Tmux config reloaded"
            "$tmux" display-message "Config relaoded by nix"
          else
            echo "Could not reload tmux"
          fi
        '';

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
      home.packages = with pkgs.internal; [
        tx
      ];

      xdg.configFile."tmuxp" = {
        enable = true;
        recursive = true;
        source = ./tmuxp/sessions;
      };
    })
  ]);
}
