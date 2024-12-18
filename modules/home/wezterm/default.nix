{
  config,
  lib,
  namespace,
  ...
}: let
  mod = "wezterm";
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "wezterm terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."wezterm/wezterm.lua".enable = false;

    xdg.configFile."wezterm" = lib.mkForce {
      source = config.lib.${namespace}.mkOutOfStoreSymlink ./lua;
      recursive = true;
    };

    programs.wezterm = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
