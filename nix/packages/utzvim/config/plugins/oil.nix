{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.plugins.oil;
in {
  plugins.oil = {
    enable = true;
    settings = {
      keymaps = {
        "q" = "actions.close";
      };
      view_options = {
        show_hidden = true;
      };
      win_options = {
        concealcursor = "ncv";
        conceallevel = 3;
        cursorcolumn = false;
        foldcolumn = "0";
        list = false;
        signcolumn = "no";
        spell = false;
        wrap = false;
      };
    };
  };

  keymaps = mkIf cfg.enable [
    {
      mode = ["n"];
      key = "<leader>e";
      action = "<cmd>Oil<cr>";
      options = {
        desc = "Open file explorer";
      };
    }
  ];
}
