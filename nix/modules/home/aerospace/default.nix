{
  pkgs,
  lib,
  namespace,
  config,
  osConfig,
  ...
}: let
  casks = lib.traceVal osConfig.homebrew.casks;
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "aerospace";
  };

  config = lib.mkIf (cfg.enable && lib.elem "aerospace" casks) {
    xdg.configFile."aerospace/aerospace.toml" = {
      source = ./aerospace.toml;
    };

    home.activation.reload-aerospace = lib.hm.dag.entryAfter ["writeBoundary"] ''
      echo "Reloading aerospace..."
      run ${osConfig.homebrew.brewPrefix}/aerospace reload-config
    '';
  };
}
