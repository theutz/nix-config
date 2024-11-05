{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  mod = "fish";
  cfg = config."internal"."${mod}";
in {
  options."internal"."${mod}" = {
    enable = mkEnableOption "fish shell configuration";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
    };
  };
}
