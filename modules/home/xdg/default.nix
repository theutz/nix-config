{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  mod = "xdg";
  cfg = config."internal"."${mod}";
in {
  options."internal"."${mod}" = {
    enable = mkEnableOption "xdg preferences";
  };

  config = mkIf cfg.enable {
    xdg.enable = true;
    home.preferXdgDirectories = true;
  };
}
