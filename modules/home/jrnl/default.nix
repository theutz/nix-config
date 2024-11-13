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
    home.packages = with pkgs; [jrnl];

    xdg.configFile."jrnl/jrnl.yaml".source =
      config.lib.${namespace}.mkOutOfStoreSymlink ./jrnl.yaml;
  };
}
