{
  lib,
  config,
  namespace,
  ...
}: let
  mod = lib.internal.path.getLastComponent ./.;
  cfg = lib.getAttrFromPath [namespace mod] config;

  options = lib.setAttrByPath [namespace mod] {
    enable = lib.mkEnableOption "less";
  };
in {
  inherit options;

  config = lib.mkIf cfg.enable {
    programs.less = {
      enable = true;
    };
  };
}
