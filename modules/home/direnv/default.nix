{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  mod = "direnv";
  cfg = config.internal.${mod};
in {
  options.internal.${mod} = {
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
