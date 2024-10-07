{ config, lib, namespace, ... }: let
  inherit (lib) mkIf mkEnableOption;

  mod = "nixvim";
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = mkEnableOption "nxivim";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
    };
  };
}
