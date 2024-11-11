{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.internal.nb;
in {
  options.internal.nb = {
    enable = lib.mkEnableOption "nb";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [nb];
  };
}
