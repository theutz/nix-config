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

  cfg = config.${namespace}.${mod};

  inherit (lib.home-manager) hm;
in {
  options.${namespace}.${mod} = {
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

          echo "Resetting tmux env"

          vars=(
              __NIX_DARWIN_SET_ENVIRONMENT_DONE
              __HM_SESS_VARS_SOURCED
              __HM_ZSH_VARS_SOURCED
          )

          for var in "$vars[@]"; do
              echo "Unsetting $var"
              if run "$tmux" setenv -gu "$var"; then
                echo "Unset $var globally"
              fi
              if run "$tmux" setenv -u "$var"; then
                echo "Unset $var for session"
              fi
          done

          echo "Tmux env reset"

          conf_file="${lib.concatStringsSep "/" [
            config.xdg.configHome
            "tmux"
            "tmux.conf"
          ]}"

          echo "Reloading tmux config..."
          if run "$tmux" source-file "$conf_file"; then
            echo "Tmux config reloaded"
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
      home.packages = with pkgs.${namespace}; [
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
