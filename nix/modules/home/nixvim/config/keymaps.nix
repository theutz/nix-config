{lib, ...}: {
  keymaps = [
    {
      mode = ["n"];
      key = "<C-s>";
      action = "<cmd>w<cr>";
      options = {
        desc = "Save file";
      };
    }
    {
      mode = ["n" "i"];
      key = "<esc>";
      action = "<cmd>nohl<cr><esc>";
      options = {desc = "Clear highlighting";};
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
