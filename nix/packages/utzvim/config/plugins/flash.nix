{
  config,
  lib,
  ...
}: let
  cfg = config.plugins.flash;
in {
  plugins.flash = {
    enable = true;
    settings = {
      multi_window = true;
      forward = true;
      wrap = true;
      modes.search.enabled = true;
    };
  };

  keymaps = lib.mkIf cfg.enable [
    {
      mode = ["n" "x" "o"];
      key = "s";
      action.__raw = ''
        function () require("flash").jump() end
      '';
      options.desc = "Flash";
    }
    {
      mode = ["n" "x" "o"];
      key = "S";
      action.__raw = ''
        function () require("flash").treesitter() end
      '';
      options.desc = "Flash Treesitter";
    }
    {
      mode = "o";
      key = "r";
      action.__raw = ''
        function () require('flash').remote() end
      '';
      options.desc = "Remote Flash";
    }
    {
      mode = ["o" "x"];
      key = "R";
      action.__raw = ''
        function () require('flash').treesitter_search() end
      '';
      options.desc = "Treesitter Search";
    }
    {
      mode = ["c"];
      key = "<c-s>";
      action.__raw = ''
        function () require('flash').toggle() end
      '';
      options.desc = "Toggle Flash Search";
    }
  ];
}
