return {
  {
    "mrjones2014/smart-splits.nvim",
    enabled = true,
    lazy = false,
    opts = {
      at_edge = "stop",
    },
    keys = {
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Focus left window" },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Focus down window" },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Focus up window" },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Focus right window" },
      { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize window left" },
      { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize window down" },
      { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize window up" },
      { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize window right" },
      {
        "<S-A-h>",
        function() require("smart-splits").swap_buf_left { move_cursor = true } end,
        desc = "Swap buffer left",
      },
      {
        "<S-A-j>",
        function() require("smart-splits").swap_buf_down { move_cursor = true } end,
        desc = "Swap buffer down",
      },
      {
        "<S-A-k>",
        function() require("smart-splits").swap_buf_up { move_cursor = true } end,
        desc = "Swap buffer up",
      },
      {
        "<S-A-l>",
        function() require("smart-splits").swap_buf_right { move_cursor = true } end,
        desc = "Swap buffer right",
      },
    },
  },
}
