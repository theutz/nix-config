{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types mkMerge;

  mod = "lf";
  cfg = config."internal"."${mod}";

  autoCdFn = ''
    lfcd () {
      cd "$(command lf -print-last-dir "$@")"
    }
  '';

  autoCdAlias = {
    lf = "lfcd";
  };
in {
  options."internal"."${mod}" = {
    enable = mkEnableOption "lf file manager";
    autoCd = mkOption {
      default = config.programs.zsh.enable;
      example = ''
        internal.${mod}.autoCd = true;
      '';
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    programs.lf = {
      enable = true;

      previewer = {
        source = pkgs.writeShellScript "pv.sh" ''
          #!/usr/bin/env sh

          case "$1" in
            *) bat "$1"
          esac
        '';
      };

      commands = mkMerge [
        (mkIf config.programs.zoxide.enable {
          z = ''
            %{{
              result="$(zoxide query --exclude "$PWD" "$@" | sed 's/\\/\\\\/g;s/"/\\"/g')"
              lf -remote "send $id cd \"$result\""
            }}
          '';
          zi = ''
            ''${{
              result="$(zoxide query -i | sed 's/\\/\\\\/g;s/"/\\"/g')"
              lf -remote "send $id cd \"$result\""
            }}
          '';
          on-cd = ''
            zoxide add "$PWD"
          '';
        })
      ];
    };

    programs.zsh.initExtra = autoCdFn;
    programs.zsh.shellAliases = mkIf cfg.autoCd autoCdAlias;

    programs.bash.initExtra = autoCdFn;
    programs.bash.shellAliases = mkIf cfg.autoCd autoCdAlias;
  };
}
