return {
  {
    "mikavilpas/yazi.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    config = true,
    keys = {
      { "<leader>e", function() require("yazi").yazi() end, desc = "Open file explorer" },
    },
    opts = {
      open_for_directories = true,
      floating_window_scaling_factor = 0.9,
      yazi_floating_window_winblend = 0,
    },
  },
}
