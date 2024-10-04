return {
  {
    "LhKipp/nvim-nu",
    opts = {
      use_lsp_features = false,
    },
    config = true,
    build = ":TSInstall nu",
  },
}
