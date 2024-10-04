return {
  {
    "nvim-neorg/neorg",
    enabled = false,
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim", "folke/which-key.nvim" },
    event = "VeryLazy",
    keys = {
      { "<leader>nn", "<cmd>Neorg<cr>", desc = "Neorg" },
      { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Neorg Index" },
      { "<leader>nc", "<cmd>Neorg toggle-concealer<cr>", desc = "Toggle Concealer", ft = "norg" },
      { "<leader>nh", "<cmd>vert help neorg-cheatsheet<cr>", desc = "Cheatsheet", ft = "norg" },
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/.local/share/neorg",
            },
            default_workspace = "notes",
          },
        },
      },
    },
    config = function(_, opts)
      require("neorg").setup(opts)
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
}
