{ config, lib, namespace, ... }: let
  inherit (lib) mkIf mkEnableOption;

  mod = "zoxide";
  cfg = config."${namespace}"."${mod}";
in {
  options."${namespace}"."${mod}" = {
    enable = mkEnableOption "zoxide directory helper";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
