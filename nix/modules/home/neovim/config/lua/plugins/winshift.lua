return {
  {
    "sindrets/winshift.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>wm", "<Cmd>WinShift<cr>", desc = "Move window" },
      { "<leader>ww", "<Cmd>WinShift swap<cr>", desc = "Swap window" },
    },
  },
}
