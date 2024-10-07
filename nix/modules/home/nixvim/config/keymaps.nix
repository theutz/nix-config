{lib, ...}: {
  keymaps =
    [
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
      {
        mode = ["n"];
        key = "<leader>qq";
        action = "<cmd>xa<cr>";
        options = {desc = "Write all and quit";};
      }
      {
        mode = ["n"];
        key = "<leader><tab>n";
        action = "<cmd>tabnext<cr>";
        options = {desc = "Next tab";};
      }
      {
        mode = ["n"];
        key = "<leader><tab>]";
        action = "<cmd>tabnext<cr>";
        options = {desc = "Next tab";};
      }
      {
        mode = ["n"];
        key = "<leader><tab>p";
        action = "<cmd>tabprev<cr>";
        options = {desc = "Prev tab";};
      }
      {
        mode = ["n"];
        key = "<leader><tab>[";
        action = "<cmd>tabprev<cr>";
        options = {desc = "Prev tab";};
      }
      {
        mode = ["n"];
        key = "<leader><tab><space>";
        action = "<cmd>wincmd T<cr>";
        options = {desc = "Open in new tab";};
      }
    ]
    ++ (builtins.map (arg: let
        inherit (lib) elemAt;
        key = elemAt arg 0;
        desc = elemAt arg 1;
      in {
        mode = ["n"];
        key = "<leader>w${key}";
        action = "<cmd>wincmd ${key}<cr>";
        options = {inherit desc;};
      }) [
        ["q" "Close window"]
      ]);
}
