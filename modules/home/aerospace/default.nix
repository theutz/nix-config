{
  pkgs,
  lib,
  namespace,
  config,
  osConfig,
  ...
}: let
  inherit (lib.home-manager) hm;

  mod = lib.internal.path.getLastComponent ./.;
  cfg = config.internal.${mod};

  casks = lib.forEach osConfig.homebrew.casks (lib.getAttr "name");
  isInstalled = lib.elem mod casks;
in {
  options.internal.${mod} = {
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
