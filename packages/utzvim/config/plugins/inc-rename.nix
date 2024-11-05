{
  plugins.inc-rename = {
    enable = true;
    inputBufferType = "dressing";
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cr";
      action = "<cmd>IncRename<cr>";
      options.desc = "Rename";
    }
  ];
}
