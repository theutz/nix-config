return {
  {
    "LudoPinelli/comment-box.nvim",
    enabled = false,
    config = true,
    event = "VeryLazy",
    init = function()
      require("which-key").register({
        ["<leader>cb"] = {
          name = "comment box",
          i = { name = "(line)", mode = "n" },
          a = {
            name = "(box) adapted",
          },
          l = {
            name = "(box) left",
          },
          c = {
            name = "(box) center",
          },
          r = {
            name = "(box) right",
          },
        },
      }, { mode = { "n", "v" } })
    end,
    keys = {
      { "<leader>cb?", mode = { "n", "v" }, "<cmd>CBcatalog<cr>", desc = "catalog" },

      --  ╭──────────────╮
      --  │ Adapted Left │
      --  ╰──────────────╯
      { "<leader>cbal", mode = { "n", "v" }, ":CBalbox", desc = "(text) left" },

      --                              ╭────────────────╮
      --                              │ Adapted Center │
      --                              ╰────────────────╯
      { "<leader>cbac", mode = { "n", "v" }, ":CBacbox", desc = "(text) center" },

      --                                                             ╭───────────────╮
      --                                                             │ Adapted Right │
      --                                                             ╰───────────────╯
      { "<leader>cbar", mode = { "n", "v" }, ":CBarbox", desc = "(text) right" },

      --  ╭──────────────────────────────────────────────────────────╮
      --  │ Fixed Left Left                                          │
      --  ╰──────────────────────────────────────────────────────────╯
      { "<leader>cbll", mode = { "n", "v" }, ":CBllbox", desc = "(text) left" },

      --  ╭──────────────────────────────────────────────────────────╮
      --  │                    Fixed Left Center                     │
      --  ╰──────────────────────────────────────────────────────────╯
      { "<leader>cblc", mode = { "n", "v" }, ":CBlcbox", desc = "(text) center" },

      --  ╭──────────────────────────────────────────────────────────╮
      --  │                                         Fixed Left Right │
      --  ╰──────────────────────────────────────────────────────────╯
      { "<leader>cblr", mode = { "n", "v" }, ":CBlrbox", desc = "(text) right" },

      --         ╭──────────────────────────────────────────────────────────╮
      --         │ Fixed Center Left                                        │
      --         ╰──────────────────────────────────────────────────────────╯
      { "<leader>cbcl", mode = { "n", "v" }, ":CBclbox", desc = "(text) left" },

      --         ╭──────────────────────────────────────────────────────────╮
      --         │                   Fixed Center Center                    │
      --         ╰──────────────────────────────────────────────────────────╯
      { "<leader>cbcc", mode = { "n", "v" }, ":CBccbox", desc = "(text) center" },

      --         ╭──────────────────────────────────────────────────────────╮
      --         │                                       Fixed Center Right │
      --         ╰──────────────────────────────────────────────────────────╯
      { "<leader>cbcr", mode = { "n", "v" }, ":CBcrbox", desc = "(text) right" },

      --                  ╭──────────────────────────────────────────────────────────╮
      --                  │ Fixed Right Left                                         │
      --                  ╰──────────────────────────────────────────────────────────╯
      { "<leader>cbrl", mode = { "n", "v" }, ":CBrlbox", desc = "(text) left" },

      --                  ╭──────────────────────────────────────────────────────────╮
      --                  │                    Fixed Right Center                    │
      --                  ╰──────────────────────────────────────────────────────────╯
      { "<leader>cbrc", mode = { "n", "v" }, ":CBrcbox", desc = "(text) center" },

      --                  ╭──────────────────────────────────────────────────────────╮
      --                  │                                        Fixed Right Right │
      --                  ╰──────────────────────────────────────────────────────────╯
      { "<leader>cbrr", mode = { "n", "v" }, ":CBrrbox", desc = "(text) right" },

      -- Line Left
      --  ────────────────────────────────────────────────────────────
      { "<leader>cbil", mode = { "n" }, ":CBline", desc = "(line) left" },

      -- Line Center
      --      ────────────────────────────────────────────────────────────
      { "<leader>cbic", mode = { "n" }, ":CBcline", desc = "(line) center" },

      -- Line Right
      --                  ────────────────────────────────────────────────────────────
      { "<leader>cbir", mode = { "n" }, ":CBrline", desc = "(line) right" },
    },
  },
}
