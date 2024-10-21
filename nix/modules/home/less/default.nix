{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  inherit (lib.theutz.modules) getLastComponent;
  inherit (lib.attrsets) getAttrFromPath setAttrByPath;

  mod = getLastComponent ./.;
  cfg = getAttrFromPath [namespace mod] config;

  options = setAttrByPath [namespace mod] {
    enable = mkEnableOption "less";
  };
in {
  inherit options;

  config = mkIf cfg.enable {
    programs.less = {
      enable = true;
    };
  };
}
