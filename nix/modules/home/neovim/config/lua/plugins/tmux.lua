return {
  {
    "aserowy/tmux.nvim",
    enabled = false,
    module = "tmux",
    config = true,
    opts = {
      copy_sync = {
        enable = false,
      },
      navigation = {
        enable_default_keybindings = true,
        persist_zoom = true,
      },
      resize = {
        enable_default_keybindings = false,
      },
    },
    keys = {
      {
        "<C-h>",
        function() require("tmux").move_left() end,
      },
      {
        "<C-j>",
        function() require("tmux").move_down() end,
      },
      {
        "<C-k>",
        function() require("tmux").move_up() end,
      },
      {
        "<C-l>",
        function() require("tmux").move_right() end,
      },
    },
  },
}
