return {
  {
    "stevearc/oil.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      view_options = {
        show_hidden = true,
      },
      columns = {
        "icon",
        "permissions",
        -- "size",
        -- "mtime",
      },
      keymaps = {
        ["?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["q"] = "actions.close",
        ["gr"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
      },
      use_default_keymaps = false,
      default_file_explorer = true,
    },
    keys = {
      {
        "<leader>fo",
        function() require("oil").open() end,
        desc = "Open parent directory",
      },
      {
        "<leader>e",
        function() require("oil").open() end,
        desc = "Open parent directory",
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
