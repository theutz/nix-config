{
  config,
  lib,
  ...
}: let
  cfg = config.plugins.easy-align;
in {
  plugins.easy-align = {
    enable = true;
  };

  keymaps = lib.mkIf cfg.enable [
    {
      mode = ["n" "x"];
      key = "ga";
      action = "<Plug>(EasyAlign)";
      options.desc = "EasyAlign";
    }
  ];
}
