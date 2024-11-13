{
  config,
  lib,
namespace,
  pkgs,
  ...
}: let
  mod = "wezterm";
  cfg = config.internal.${mod};
in {
  options.internal.${mod} = {
    enable = lib.mkEnableOption "wezterm terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."wezterm/wezterm.lua".enable = false;

    xdg.configFile."wezterm" = lib.mkForce {
      source = config.lib.${namespace}.mkOutOfStoreSymlink ./config;
      recursive = true;
    };

    programs.wezterm = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
