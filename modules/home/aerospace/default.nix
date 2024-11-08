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

  mkFlags = lib.cli.toGNUCommandLineShell {};
  mkArgs = args: lib.concatStringsSep " " (lib.mapAttrsToList (name: value: "${name}=${builtins.toString value}") args);

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
    after-startup-command =
      lib.forEach [
        [borders (mkArgs defaultBorders)]
        [sketchybar (mkFlags {reload = true;})]
      ] (x:
        lib.pipe x [
          (lib.concat ["exec-and-forget"])
          (lib.concatStringsSep " ")
        ]);
    exec-on-workspace-change = [
      ''
        ${sketchybar} --trigger aerospace_workspace_change FOCUSED=$AEROSPACE_FOCUSED_WORKSPACE
      ''
    ];
    enable-normalization-flatten-containers = true;
    enable-normalization-opposite-orientation-for-nested-containers = true;
    accordion-padding = 32;
    default-root-container-layout = "tiles";
    default-root-container-orientation = "auto";
    key-mapping.preset = "qwerty";

    gaps = let
      gap = 20;
    in {
      inner = {
        horizontal = gap;
        vertical = gap;
      };
      outer = {
        left = gap;
        bottom = gap;
        top = [{monitor."SAMSUNG" = 56;} gap];
        right = gap;
      };
    };
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
