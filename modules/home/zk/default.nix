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

    settings = lib.mkOption {
      inherit (tomlFormat) type;
      description = ''
        Configuration defined at https://zk-org.github.io/zk/config/config.html.
      '';
      default = {
        note = {
          language = "en";
        };

        extra = {
          user = config.home.username;
        };

        tool = lib.traceValSeq {
          editor = config.home.sessionVariables.EDITOR;
          shell = lib.getExe pkgs.zsh;
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
