{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  mod = "bat";
  cfg = config."internal"."${mod}";
in {
  options."internal"."${mod}" = {
    enable = mkEnableOption "bat: a cat replacement";
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
    };
  };
}
