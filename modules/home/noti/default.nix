{
  lib,
  config,
  namespace,
  ...
}: let
  mod = lib.internal.path.getLastComponent ./.;
  cfg = config.internal.${mod};
in {
  options.internal.${mod} = {
    enable = lib.mkEnableOption "${mod}";
  };

  config = lib.mkIf cfg.enable {
    programs.noti = {
      enable = true;
    };
  };
}
