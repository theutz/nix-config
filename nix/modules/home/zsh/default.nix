{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkMerge;

  mod = "zsh";
  cfg = config."${namespace}"."${mod}";
in {
  options."${namespace}"."${mod}" = {
    enable = mkEnableOption "zsh settings";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      shellAliases = mkMerge [
        (mkIf config.programs.lazygit.enable {
          lg = "lazygit";
        })
      ];
    };
  };
}
