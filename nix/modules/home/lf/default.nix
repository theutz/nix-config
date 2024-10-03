{ config, lib, namespace, ... }: let
  inherit (lib) mkEnableOption mkIf;
  mod = "lf";
  cfg = config."${namespace}"."${mod}";
in {
  options."${namespace}"."${mod}" = {
    enable = mkEnableOption "lf file manager";
  };

  config = mkIf cfg.enable {
    programs.lf = {
      enable = true;
    };
  };
}
