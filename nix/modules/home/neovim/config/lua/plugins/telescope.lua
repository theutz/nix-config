return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        buffers = {
          mappings = {
            n = {
              d = require("telescope.actions").delete_buffer,
            },
            i = {
              ["<c-q>"] = require("telescope.actions").delete_buffer,
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>;",
        function() require("telescope.builtin").current_buffer_fuzzy_find() end,
        desc = "Search within current buffer",
      },
      {
        "<leader>;",
        function() require("telescope.builtin").live_grep { grep_open_files = true } end,
        desc = "Search open buffers",
      },
      {
        "<leader>sc",
        "<cmd>Telescope commands<cr>",
        desc = "Commands",
      },
      {
        "<leader>sC",
        false,
      },
    },
  },
}
