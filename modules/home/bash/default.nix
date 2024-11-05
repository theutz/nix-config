{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  mod = lib.internal.path.getLastComponent ./.;
  cfg = config.internal.${mod};
in {
  options.internal.${mod} = {
    enable = mkEnableOption "bash shell config";
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
    };
  };
}
