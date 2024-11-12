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
    home.packages = with pkgs; [
      nb
      pandoc
      readability-cli
      tig
      ripgrep
      imgcat
      catimg
      glow
      tidy-viewer
    ];

    home.sessionVariables = {
      NB_DIR = lib.path.append (/. + config.home.homeDirectory) ".nb";
      NBRC_PATH = config.xdg.configFile.nbrc.source;
      NB_MARKDOWN_TOOL = lib.getExe pkgs.glow;
      NB_DIRECTORY_TOOL = lib.getExe pkgs.yazi;
      NB_DATA_TOOL = lib.getExe pkgs.tidy-viewer;
    };

    xdg.configFile."nbrc".source = mkOutOfStoreSymlink ./nbrc.sh;
  };
}
