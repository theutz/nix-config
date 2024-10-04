return {
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
    opts = function(_, opts)
      opts.config.header = "Hey"
      opts.config.center[6].action = "SessionLoad"
      return opts
    end,
  },
}
