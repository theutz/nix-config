{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  mod = "direnv";
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

      config = {
        global = {
          hide_env_diff = true;
        };
      };

      nix-direnv.enable = true;
    };
  };
}
