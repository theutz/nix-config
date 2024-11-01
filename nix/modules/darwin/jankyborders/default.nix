{
  pkgs,
  lib,
  config,
  namespace,
  ...
}: let
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption mod;
  };

  config = lib.mkIf (cfg.enable) {
    services.jankyborders = {
      enable = true;
      active_color = "0x88FF0000";
      inactive_color = "0x00000000";
      hidpi = true;
      # background_color = "";
      blur_radius = 2.0;
      style = "round";
      width = 5.0;
      blacklist = [];
    };
  };
}
