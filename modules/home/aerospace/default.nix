{
  pkgs,
  lib,
  config,
  osConfig,
  namespace,
  ...
}: let
  mod = "aerospace";
  cfg = config.${namespace}.${mod};
  isInstalled = lib.pipe osConfig.homebrew.casks [
    (lib.map (lib.getAttr "name"))
    (lib.elem mod)
  ];

  borders = lib.getExe config.services.jankyborders.package or pkgs.jankyborders;
  sketchybar = lib.getExe pkgs.sketchybar;
  neovide = lib.getExe pkgs.neovide;
  bash = lib.getExe pkgs.bashInteractive;
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "tiling window manager for darwin";
  };

  config = lib.mkIf (cfg.enable && isInstalled) {
    xdg.configFile."aerospace/aerospace.toml" = {
      # source = settingsFile;
      source = pkgs.replaceVars ./aerospace.toml {
        inherit borders sketchybar neovide bash;
      };
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
