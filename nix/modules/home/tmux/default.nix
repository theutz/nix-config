{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.theutz) getLastComponent;

  mod = getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = mkEnableOption mod;
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      extraConfig = builtins.readFile ./tmux.conf;
      plugins = with pkgs; [
        tmuxPlugins.sessionist
        tmuxPlugins.pain-control
        tmuxPlugins.yank
      ];
      escapeTime = 0;
      mouse = true;
      keyMode = "vi";
      prefix = "C-b";
      resizeAmount = 5;

      tmuxp.enable = true;
    };

    xdg.configFile."tmuxp" = {
      enable = true;
      recursive = true;
      source = ./sessions;
    };
  };
}
