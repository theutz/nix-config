return {
  {
    "protex/better-digraphs.nvim",
    event = "VeryLazy",
    keys = {
      { "<C-k><C-k>", function() require("better-digraphs").digraphs "insert" end, mode = { "i" } },
    },
    config = function() end,
  },
}
