return {
  {
    "mtth/scratch.vim",
    enabled = false,
    event = "VeryLazy",
    init = function()
      vim.g.scratch_no_mappings = true
      vim.g.scratch_filetype = "norg"
      vim.g.scratch_insert_autohide = false
    end,
    dependencies = { "folke/which-key.nvim" },
    config = function()
      local wk = require "which-key"
      wk.add {
        { "<leader>n", group = "notes" },
      }
    end,
    keys = {
      { "<leader>nn", "<cmd>ScratchPreview<cr>", desc = "Toggle scratch buffer" },
      { "<leader>ns", "<plug>(scratch-insert-reuse)", desc = "Open scratch buffer" },
      { "<leader>nS", "<plug>(scratch-insert-clear)", desc = "Open and clear scratch buffer" },
    },
  },
}
