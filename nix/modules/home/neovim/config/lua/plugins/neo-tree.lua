return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    opts = {
      filesystem = {
        -- hijack_netrw_behavior = "disabled",
        filtered_items = {
          hide_dotfiles = false,
        },
        window = {
          mappings = {
            ["H"] = "navigate_up",
            ["-"] = "navigate_up",
            ["zh"] = "toggle_hidden",
            ["L"] = { "toggle_preview", config = { use_float = true } },
          },
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path) require("neo-tree.command").execute { action = "close" } end,
        },
      },
    },
  },
}
