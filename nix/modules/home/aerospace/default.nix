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

    home.activation.reload-aerospace = hm.dag.entryAfter ["writeBoundary"] ''
      verboseEcho "Reloading aerospace..."
      if run --quiet ${osConfig.homebrew.brewPrefix}/${mod} reload-config; then
        verboseEcho "Aerospace reloaded."
      else
        verboseEcho "Unable to reload"
      fi
    '';
  };
}
