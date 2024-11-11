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
        notebook = {
          dir = "~/notes";
        };

        note = {
          language = "en";
        };

        extra = {
          user = config.home.username;
        };

        tool = {
          editor = config.home.sessionVariables.EDITOR;
          shell = lib.getExe pkgs.zsh;
        };

        alias = {
          edlast = "zk edit --limit 1 --sort modified- $@";
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
