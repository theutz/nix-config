{
  plugins.bufdelete = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>Bdelete<cr>";
      options.desc = "Delete buffer";
    }
  ];
}
