{
  plugins.bufferline = {
    enable = true;
    settings = {};
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>bm";
      action = "<cmd>BufferLineTogglePin<cr>";
      options.desc = "Toggle pin";
    }
    {
      mode = "n";
      key = "<leader>bo";
      action = "<cmd>BufferLineCloseOthers<cr>";
      options.desc = "Close buffers (other)";
    }
    {
      mode = "n";
      key = "<leader>bl";
      action = "<cmd>BufferLineCloseLeft<cr>";
      options.desc = "Close buffers (left)";
    }
    {
      mode = "n";
      key = "<leader>br";
      action = "<cmd>BufferLineCloseRight<cr>";
      options.desc = "Close buffers (right)";
    }
    {
      mode = "n";
      key = "<leader>b>";
      action = "<cmd>BufferLineMoveNext<cr>";
      options.desc = "Move buffer right";
    }
    {
      mode = "n";
      key = "<leader>b<";
      action = "<cmd>BufferLineMovePrev<cr>";
      options.desc = "Move buffer left";
    }
    {
      mode = "n";
      key = "<leader>b.";
      action = "<cmd>BufferLinePick<cr>";
      options.desc = "Pick buffer";
    }
    {
      mode = "n";
      key = "<leader>bM";
      action = "<cmd>BufferLineGroupClose ungrouped<cr>";
      options.desc = "Close buffers (unpinned)";
    }
  ];
}
