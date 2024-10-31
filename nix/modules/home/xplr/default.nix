{
  lib,
  config,
  namespace,
  ...
}: let
  mod = lib.theutz.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "${mod}";
  };

  config = lib.mkIf cfg.enable {
    programs.xplr = {
      enable = true;
    };
  };
}
