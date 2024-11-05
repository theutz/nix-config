{
  pkgs,
  lib,
  namespace,
  config,
  osConfig,
  ...
}: let
  inherit (lib.home-manager) hm;

  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};

  casks = lib.forEach osConfig.homebrew.casks (lib.getAttr "name");
  isInstalled = lib.elem mod casks;
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "tiling window manager for darwin";
  };

  config = lib.mkIf (cfg.enable && isInstalled) {
    xdg.configFile."aerospace/aerospace.toml" = {
      source = ./aerospace.toml;
    };

    home.activation.reloadAerospace =
      hm.dag.entryAfter ["writeBoundary" "setupLaunchAgents"]
      /*
      bash
      */
      ''
        if run ${osConfig.homebrew.brewPrefix}/${mod} reload-config; then
          echo "Aerospace reloaded."
        else
          echo "Unable to reload aerospace."
        fi
      '';
  };
}
