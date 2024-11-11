{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.internal.nb;
  mkOutOfStoreSymlink = lib.internal.mkOutOfStoreSymlink' config;
in {
  options.internal.nb = {
    enable = lib.mkEnableOption "nb";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [nb];

    xdg.configFile."nbrc".source = mkOutOfStoreSymlink ./nbrc.sh;
  };
}
