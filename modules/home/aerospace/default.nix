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

  borders = lib.getExe config.services.jankyborders.package or pkgs.jankyborders;
  sketchybar = lib.getExe pkgs.sketchybar;

  colors = {
    active = "0xff7dcff";
    inactive = "0x88a9b1d6";
  };

  mkArgs = lib.cli.toGNUCommandLineShell {};
  defaultBorders = {
    active_color = colors.active;
    inactive_color = colors.inactive;
    blur_radius = 12;
    width = 8.0;
    hidipi = true;
    style = "round";
  };

  settingsFormat = pkgs.formats.toml {};
  settingsFile = settingsFormat.generate "aerospace.toml" settings;
  settings = {
    start-at-login = true;
    after-startup-command = lib.forEach [
      (lib.concatStrings [borders (mkArgs defaultBorders)])
      (lib.concatStrings [sketchybar (mkArgs {reload = true;})])
    ] (x: "exec-and-forget ${x}");
  };
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
