{ config, lib, namespace, ... }: let
  inherit (lib) mkIf mkEnableOption;

  mod = "xdg";
  cfg = config."${namespace}"."${mod}";
in {
  options."${namespace}"."${mod}" = {
    enable = mkEnableOption "xdg preferences";
  };

  config = mkIf cfg.enable {
    xdg.enable = true;
    home.preferXdgDirectories = true;
  };
}
