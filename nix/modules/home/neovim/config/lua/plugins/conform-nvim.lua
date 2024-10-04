return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        php = { "pint" },
        blade = { "blade-formatter", "rustywind" },
        javascript = { "prettierd" },
        html = { "prettierd", "rustywind" },
        htmlhugo = { "prettierd", "rustywind" },
      },
    },
  },
}
