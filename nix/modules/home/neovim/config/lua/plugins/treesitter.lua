return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = "all",
      indent = {
        enable = true,
        disable = { "yaml", "php" },
      },
    },
  },
}
