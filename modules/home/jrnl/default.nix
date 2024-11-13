{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};

  yamlFormat = pkgs.formats.yaml {};

  mkJrnlPath = x: (lib.concatStringsSep "/"
    [
      config.home.homeDirectory
      "Dropbox"
      "jrnl"
      (lib.concatStrings [x ".txt"])
    ]);

  settings = {
    colors = {
      body = "none";
      date = "black";
      tags = "yellow";
      title = "cyan";
    };
    default_hour = 9;
    default_minute = 0;
    editor = config.home.sessionVariables.EDITOR;
    encrypt = true;
    highlight = true;
    indent_character = "|";
    journals = {
      default = {
        journal = mkJrnlPath "settings";
        delegator = mkJrnlPath "delegator";
      };
    };
    linewrap = 79;
    tagsymbols = "#@";
    template = false;
    timeformat = "%F %r";
    version = "v4.1";
  };
in {
  options.${namespace}.${mod}.enable = lib.mkEnableOption mod;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [jrnl];

    xdg.configFile."jrnl/jrnl.yaml".source =
      yamlFormat.generate "jrnl.yaml" settings;
  };
}