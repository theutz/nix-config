{
  plugins.trouble = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>lw";
      action = "<cmd>Trouble diagnostics toggle<cr>";
      options.desc = "Diagnostics (Workspace) [Trouble]";
    }
    {
      mode = "n";
      key = "<leader>lb";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
      options.desc = "Diagnostics (Buffer) [Trouble]";
    }
    {
      mode = "n";
      key = "<leader>ll";
      action = "<cmd>Trouble loclist toggle<cr>";
      options.desc = "Location list [Trouble]";
    }
    {
      mode = "n";
      key = "<leader>lq";
      action = "<cmd>Trouble qflist toggle<cr>";
      options.desc = "QuickFix list [Trouble]";
    }
  ];
}
