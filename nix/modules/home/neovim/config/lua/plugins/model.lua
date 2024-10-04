return {
  {
    "gsuuon/model.nvim",
    enabled = false,
    dependencies = {
      "folke/which-key.nvim",
    },
    config = function()
      require("which-key").add {
        { "<leader>a", group = "ai" },
        { "<leader>ac", group = "chat" },
      }
    end,
    event = "VeryLazy",
    cmd = { "M", "Model", "Mchat" },
    init = function()
      vim.filetype.add {
        extension = {
          mchat = "mchat",
        },
      }
    end,
    ft = "mchat",
    keys = {
      { "<leader>ad", "<cmd>Mdelete<cr>", mode = "n", desc = "Delete" },
      { "<leader>as", "<cmd>Mselect<cr>", mode = "n", desc = "Select" },
      { "<leader>ac4", "<cmd>Mchat gpt4<cr>", mode = "n", desc = "Chat with GPT-4" },
      { "<leader>ac3", "<cmd>Mchat openai<cr>", mode = "n", desc = "Chat with GPT-3" },
      { "<leader>acp", "<cmd>Mchat palm<cr>", mode = "n", desc = "Chat with Palm" },
      { "<leader>aa", "<cmd>Mchat<cr>", mode = "n", desc = "Ask" },
    },
  },
}
