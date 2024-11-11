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
          submodule {
            options = {
              note = mkOption {
                type = submodule {
                  options = {
                    language = mkOption {
                      type = str;
                      default = "en";
                    };
                  };
                };
              };
            };
          };

        default = {
          note = {
            language = "en";
          };
        };
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
