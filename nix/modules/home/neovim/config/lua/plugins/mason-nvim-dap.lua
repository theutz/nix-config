return {
  {

    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "php" },
      handlers = {
        php = function(config)
          config.configurations = {
            {
              type = "php",
              request = "launch",
              name = "Listen for Xdebug",
              port = 9003,
            },
          }
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
}
