return {
  {
    "jellydn/hurl.nvim",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "hurl",
    opts = {
      debug = false,
      show_notification = false,
      mode = "split",
      formatters = {
        json = { "jq" },
        html = { "prettier", "--parser", "html" },
      },
    },
    keys = {
      { "<leader>A", "<cmd>HurlRunner<cr>", desc = "Run all requests" },
      { "<leader>a", "<cmd>HurlRunnerAt<cr>", desc = "Run request" },
      { "<leader>te", "<cmd>HurlRunnerToEntry<cr>", desc = "Run request to entry" },
      { "<leader>tm", "<cmd>HurlToggleMode<cr>", desc = "Toggle hurl mode" },
      { "<leader>tv", "<cmd>HurlVerbose<cr>", desc = "Run request (verbose)" },
      { "<leader>h", "<cmd>HurlRunner<cr>", desc = "Run request", mode = "v" },
    },
  },
}
