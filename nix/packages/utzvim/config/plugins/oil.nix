{
  lib,
  config,
  helpers,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.plugins.oil;
in {
  plugins.oil = {
    enable = true;
    settings = {
      keymaps = {
        "<localleader>?" = "actions.show_help";
        "<localleader>o" = "actions.select";
        "<localleader>v" =
          helpers.listToUnkeyedAttrs ["actions.select"]
          // {
            opts = {vertical = true;};
            desc = "Open entry in a vertical split";
          };
        "<localleader>s" =
          helpers.listToUnkeyedAttrs ["actions.select"]
          // {
            opts = {horizontal = true;};
            desc = "Open entry in a horizontal split";
          };
        "<localleader>t" =
          helpers.listToUnkeyedAttrs ["actions.select"]
          // {
            opts = {tab = true;};
            desc = "Open entry in a new tab";
          };
        "<localleader>p" = "actions.preview";
        "<localleader>c" = "actions.close";
        "<localleader>r" = "actions.refresh";
        "<cr>" = "actions.select";
        "-" = "actions.parent";
        "`" = "actions.cd";
        "_" = "actions.open_cwd";
        "~" =
          helpers.listToUnkeyedAttrs ["actions.cd"]
          // {
            opts = {scope = "tab";};
            desc = ":tcd to the current oil directory";
            mode = "n";
          };
        "<localleader>S" = "actions.change_sort";
        "<localleader>O" = "actions.open_external";
        "<localleader>." = "actions.toggle_hidden";
        "<localleader>\\" = "actions.toggle_trash";
      };
      use_default_keymaps = false;
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
