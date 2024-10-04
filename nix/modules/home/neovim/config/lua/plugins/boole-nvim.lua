return {
  {
    "nat-418/boole.nvim",
    event = "VeryLazy",
    opts = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
    },
    config = function(_, opts) require("boole").setup(opts) end,
    keys = {
      { "<C-a>", "<Cmd>Boole increment<cr>", desc = "Cycle up through related options" },
      { "<C-x>", "<Cmd>Boole decrement<cr>", desc = "Cycle down through related options" },
    },
  },
}
