{lib, ...}: {
  keymaps = [
    {
      mode = ["n"];
      key = "<leader>e";
      action = "<cmd>Oil<cr>";
      options = {
        desc = "Open file explorer";
      };
    }
    {
      mode = ["n"];
      key = "<C-s>";
      action = "<cmd>w<cr>";
      options = {
        desc = "Save file";
      };
    }
    {
      mode = ["n"];
      key = "[b";
      action = "<cmd>bp<cr>";
      options = {
        desc = "Previous buffer";
      };
    }
    {
      mode = ["n"];
      key = "]b";
      action = "<cmd>bn<cr>";
      options = {
        desc = "Next buffer";
      };
    }
  ];
}
