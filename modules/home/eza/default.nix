{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  mod = "eza";
  cfg = config."internal"."${mod}";
in {
  options."internal"."${mod}" = {
    enable = mkEnableOption "eza: an ls replacement";
  };

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;

      extraOptions = [
        "--group-directories-first"
        "--header"
      ];

      git = true;
      icons = true;
    };
  };
}
