{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.internal.zk;

  tomlFormat = pkgs.formats.toml {};

  settings = {
    note = {
      language = "en";
    };
  };
in {
  options.internal.zk.enable = lib.mkEnableOption "zk";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      zk
    ];

    xdg.configFile."zk/config.toml" = {
      source = tomlFormat.generate "zk-config" settings;
    };
  };
}
