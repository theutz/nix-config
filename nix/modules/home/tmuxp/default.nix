{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  mod = "tmuxp";
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = mkEnableOption "tmuxp";
  };

  config = mkIf cfg.enable {
    programs.tmux.tmuxp.enable = true;

    xdg.configFile."tmuxp" = {
      enable = true;
      recursive = true;
      source = ./sessions;
    };
  };
}
