{
  pkgs,
  lib,
  namespace,
  config,
  ...
}: let
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "aerospace";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."aerospace.toml" = {
      source = ./aerospace.toml;
    };
  };
}
