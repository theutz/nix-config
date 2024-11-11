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
      source = tomlFormat.generate "zk-config" (lib.traceSeq cfg cfg.settings);
    };
  };
}
