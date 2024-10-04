return {
  {
    "johmsalas/text-case.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("textcase").setup {}
      require("telescope").load_extension "textcase"
    end,
    keys = {
      { "ga.", "<cmd>TextCaseOpenTelescope<cr>", mode = { "n", "v" }, desc = "Telescope" },
    },
  },
}
