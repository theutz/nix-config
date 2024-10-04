return {
  {
    "mizlan/iswap.nvim",
    opts = {
      move_cursor = true,
    },
    keys = {
      { "<leader>co", "<Cmd>ISwap<cr>", desc = "Swap two items" },
      { "<leader>cO", "<Cmd>ISwapWith<cr>", desc = "Swap curent item" },
      { "]o", "<Cmd>ISwapWithRight<CR>", desc = "Swap with right item" },
      { "[o", "<Cmd>ISwapWithLeft<CR>", desc = "Swap with left item" },
      { "<leader>cn", "<Cmd>ISwapNode<cr>", desc = "Swap two nodes" },
      { "<leader>cN", "<Cmd>ISwapNodeWith<cr>", desc = "Swap current node" },
      { "]n", "<Cmd>ISwapNodeWithRight<CR>", desc = "Swap with right node" },
      { "[n", "<Cmd>ISwapNodeWithLeft<CR>", desc = "Swap with left node" },
    },
  },
}
