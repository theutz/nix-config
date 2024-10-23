{
  lib,
  pkgs,
  helpers,
  config,
  ...
}: let
  settings = helpers.toLuaObject {};
  cfg = config.plugins.grug-far;
in {
  options = {
    plugins.grug-far = {
      enable = lib.mkEnableOption "grug-far.nvim";
    };
  };

  config = {
    extraPlugins = lib.mkIf cfg.enable [
      pkgs.vimPlugins.grug-far-nvim
    ];

    extraConfigLua = lib.mkIf cfg.enable ''
      require('grug-far').setup(${settings})
    '';
  };
}
