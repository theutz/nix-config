{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.plugins.easy-align;
in {
  options.plugins.easy-align = {
    enable = lib.mkEnableOption "EasyAlign";
  };

  config = lib.mkIf cfg.enable {
    extraPlugins = with pkgs.vimPlugins; [
      vim-easy-align
    ];
  };
}
