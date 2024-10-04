-- vim: fdm=indent fdl=1
local colors = {
  {
    "folke/tokyonight.nvim",
    enabled = true,
    opts = {
      transparent = false,
      style = "moon",
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },
      on_colors = function(c) c.border = c.blue0 end,
    },
  },
  {
    "scottmckendry/cyberdream.nvim",
    enabled = false,
    opts = {
      transparent = true,
      italic_comments = true,
    },
  },
  {
    "echasnovski/mini.base16",
    enabled = false,
    version = false,
  },
  {
    "uloco/bluloco.nvim",
    enabled = false,
    dependencies = { "rktjmp/lush.nvim" },
    opts = {
      transparent = true,
      style = "dark",
      italics = true,
    },
  },
  {
    "bluz71/vim-moonfly-colors",
    enabled = false,
    name = "moonfly",
    lazy = false,
    priority = 1000,
  },
}

local colorscheme = "tokyonight"

local plugins = {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorscheme,
    },
  },
}

for _, color in pairs(colors) do
  color.priority = 1000
  color.lazy = false
  table.insert(plugins, color)
end

return plugins
