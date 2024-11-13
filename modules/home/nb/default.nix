{
  pkgs,
  lib,
  config,
  namespace,
  ...
}: let
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
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

    xdg.configFile."nbrc".source =
      config.lib.${namespace}.mkOutOfStoreSymlink
      ./nbrc.sh;
  };
}
