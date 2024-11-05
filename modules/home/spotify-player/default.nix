{
  lib,
  config,
  namespace,
  ...
}: let
  mod = "spotify-player";
  cfg = lib.getAttrFromPath [namespace mod] config;
in {
  options = lib.setAttrByPath [namespace mod] {
    enable = lib.mkEnableOption "spotify-player";
  };

  config = lib.mkIf cfg.enable {
    programs.spotify-player = {
      enable = true;
      settings = {
        device = {
          volume = 85;
        };
      };
    };
  };
}
