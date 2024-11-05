{
  pkgs,
  lib,
  config,
  namespace,
  ...
}: let
  mod = lib.internal.path.getLastComponent ./.;
  cfg = config.internal.${mod};
in {
  options.internal.${mod} = {
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
      width = 8.0;
      blacklist = [];
    };
  };
}
