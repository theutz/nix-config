{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  mod = "aerospace";
  cfg = config.internal.${mod};

  isInstalled = lib.pipe osConfig.homebrew.casks [
    (lib.map (lib.getAttr "name"))
    (lib.elem mod)
  ];

  settings = {
    start-at-login = true;
  };

  settingsFormat = pkgs.formats.toml {};

  settingsFile = settingsFormat.generate "aerospace.toml" settings;
in {
  options.internal.${mod} = {
    enable = lib.mkEnableOption "tiling window manager for darwin";
  };

  config = lib.mkIf (cfg.enable && isInstalled) {
    xdg.configFile."aerospace/aerospace.toml" = {
      source = settingsFile;
    };

    home.activation.reloadAerospace =
      lib.home-manager.hm.dag.entryAfter ["writeBoundary" "setupLaunchAgents"]
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
