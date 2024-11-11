{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.internal.zk;

  tomlFormat = pkgs.formats.toml {};
in {
  options.internal.zk = {
    enable = lib.mkEnableOption "zk";

    settings = with lib;
      mkOption {
        type = with types;
          attrsOf (submodule {
            options = {
              note = {
                options = {
                  language = mkOption {
                    type = str;
                    default = "en";
                    description = ''
                      Language used when writing notes.
                    '';
                  };

                  default-title = mkOption {
                    type = str;
                    default = "Untitled";
                    description = ''
                      The default title used for new note, if no `--title` flag is provided.
                    '';
                  };
                };
              };
            };
          });

        default = {};
      };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      zk
    ];

    xdg.configFile."zk/config.toml" = {
      source = tomlFormat.generate "zk-config" cfg.settings;
    };
  };
}
