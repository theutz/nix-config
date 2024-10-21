{
  lib,
  config,
  namespace,
  ...
}: let
  mod = lib.theutz.modules.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "${mod}";
  };

  config = lib.mkIf cfg.enable {
    programs.htop = {
      enable = true;
    };
  };
}
