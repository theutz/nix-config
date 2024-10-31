{
  pkgs,
  lib,
  namespace,
  config,
  osConfig,
  ...
}: let
  casks = osConfig.homebrew.casks;
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "aerospace";
  };

  config = lib.mkIf (cfg.enable && lib.elem "aerospace" casks) {
    xdg.configFile."aerospace.toml" = {
      source = ./aerospace.toml;
    };
  };
}
