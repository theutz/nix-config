{
  lib,
  config,
  namespace,
  ...
}: let
  mod = lib.internal.modules.getModName ./.;
  options = lib.setAttrByPath [namespace mod] {
    enable = lib.mkEnableOption "man";
  };
  cfg = lib.getAttrFromPath [namespace mod] config;
in {
  inherit options;

  config = lib.mkIf cfg.enable {
    programs.man = {
      enable = true;
    };
  };
}
