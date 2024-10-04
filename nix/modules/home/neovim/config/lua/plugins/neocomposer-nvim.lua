return {
  {
    "ecthelionvi/NeoComposer.nvim",
    enabled = false,
    dependencies = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" },
    opts = {},
    config = function(_, opts)
      require("NeoComposer").setup(opts)
      require("telescope").load_extension "macros"
      require("NeoComposer.ui").status_recording()
    end,
  },
}
