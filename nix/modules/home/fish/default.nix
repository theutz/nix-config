{ config, lib, namespace, ... }: let
  inherit (lib) mkIf mkEnableOption;

  mod = "fish";
  cfg = config."${namespace}"."${mod}";
in {
  options."${namespace}"."${mod}" = {
    enable = mkEnableOption "fish shell configuration";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
    };
  };
}
