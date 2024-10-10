{
  plugins.auto-session = {
    enable = true;
    settings = {
      use_git_branch = true;
    };
  };

  keymaps = [
    {
      mode = ["n"];
      key = "<leader>qs";
      action = "<cmd>SessionSave<cr>";
      options = {desc = "Save session";};
    }
    {
      mode = ["n"];
      key = "<leader>qx";
      action = "<cmd>SessionDelete<cr>";
      options = {desc = "Delete session";};
    }
  ];
}
