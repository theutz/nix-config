-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.foldcolumn = "2"

-- Stop annoying delays with escape key
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 0

if vim.g.neovide then require "config.neovide" end

vim.o.exrc = true

-- Use nushell
-- vim.o.shell = "nu"
-- vim.o.shellcmdflag = "-c"
-- vim.o.shellquote = ""
-- vim.o.shellxquote = ""
