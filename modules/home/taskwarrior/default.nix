{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod}.enable = lib.mkEnableOption mod;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      timewarrior
      tasksh
      vit
    ];

    programs.taskwarrior = {
      enable = true;
      config = {};
    };

    xdg.configFile.
      "timewarrior/timewarrior.cfg".source =
      config.lib.${namespace}.mkOutOfStoreSymlink
      ./timewarrior.cfg;
  };
}
