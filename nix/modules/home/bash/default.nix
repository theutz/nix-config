{ config, lib, namespace, ... }: let
  inherit (lib) mkIf mkEnableOption;

  mod = "bash";
  cfg = config."${namespace}"."${mod}";
in {
  options."${namespace}"."${mod}" = {
    enable = mkEnableOption "bash shell config";
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
    };
  };
}
