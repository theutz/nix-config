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

    home.sessionVariables = {
      NB_DIR = lib.path.append (/. + config.home.homeDirectory) ".nb";
      NBRC_PATH = config.xdg.configFile.nbrc.source;
    };

    xdg.configFile."nbrc".source = mkOutOfStoreSymlink ./nbrc.sh;
  };
}
