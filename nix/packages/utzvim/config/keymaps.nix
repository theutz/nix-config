let
  winKeys = [
    {
      mode = "n";
      key = "<leader>w+";
      action = "<cmd>wincmd +<cr>";
      options.desc = "Increase height";
    }
    {
      mode = "n";
      key = "<leader>w-";
      action = "<cmd>wincmd -<cr>";
      options.desc = "Decrease height";
    }
    {
      mode = "n";
      key = "<leader>w<";
      action = "<cmd>wincmd <<cr>";
      options.desc = "Decrease width";
    }
    {
      mode = "n";
      key = "<leader>w=";
      action = "<cmd>wincmd =<cr>";
      options.desc = "Equal width and height";
    }
    {
      mode = "n";
      key = "<leader>w>";
      action = "<cmd>wincmd ><cr>";
      options.desc = "Increase width";
    }
    {
      mode = "n";
      key = "<leader>w_";
      action = "<cmd>wincmd _<cr>";
      options.desc = "Max out the height";
    }
    {
      mode = "n";
      key = "<leader>wh";
      action = "<cmd>wincmd h<cr>";
      options.desc = "Focus left window";
    }
    {
      mode = "n";
      key = "<leader>wj";
      action = "<cmd>wincmd j<cr>";
      options.desc = "Focus window below";
    }
    {
      mode = "n";
      key = "<leader>wk";
      action = "<cmd>wincmd k<cr>";
      options.desc = "Focus window above";
    }
    {
      mode = "n";
      key = "<leader>wl";
      action = "<cmd>wincmd l<cr>";
      options.desc = "Focus right window";
    }
    {
      mode = "n";
      key = "<leader>wo";
      action = "<cmd>wincmd o<cr>";
      options.desc = "Close all others";
    }
    {
      mode = "n";
      key = "<leader>wq";
      action = "<cmd>wincmd q<cr>";
      options.desc = "Close window";
    }
    {
      mode = "n";
      key = "<leader>wd";
      action = "<cmd>wincmd q<cr>";
      options.desc = "Close window";
    }
    {
      mode = "n";
      key = "<leader>ws";
      action = "<cmd>wincmd s<cr>";
      options.desc = "Split window horizontally";
    }
    {
      mode = "n";
      key = "<leader>wT";
      action = "<cmd>wincmd T<cr>";
      options.desc = "Break into new tab";
    }
    {
      mode = "n";
      key = "<leader>wv";
      action = "<cmd>wincmd v<cr>";
      options.desc = "Split window vertically";
    }
    {
      mode = "n";
      key = "<leader>ww";
      action = "<cmd>wincmd w<cr>";
      options.desc = "Switch windows";
    }
    {
      mode = "n";
      key = "<leader>wx";
      action = "<cmd>wincmd x<cr>";
      options.desc = "Swap current with next";
    }
    {
      mode = "n";
      key = "<leader>w|";
      action = "<cmd>wincmd |<cr>";
      options.desc = "Max out the width";
    }
  ];

  bufferKeys = [
    {
      mode = "n";
      key = "<leader>bD";
      action = "<cmd>bd!<cr>";
      options.desc = "Delete buffer (force)";
    }
    {
      mode = "n";
      key = "<leader>bb";
      action = "<cmd>e #<cr>";
      options.desc = "Most recent buffer";
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>bp<cr>";
      options.desc = "Prev buffer";
    }
    {
      mode = "n";
      key = "<leader>bn";
      action = "<cmd>bn<cr>";
      options.desc = "Next buffer";
    }
    {
      mode = "n";
      key = "[b";
      action = "<cmd>bp<cr>";
      options = {
        desc = "Prev buffer";
      };
    }
    {
      mode = "n";
      key = "]b";
      action = "<cmd>bn<cr>";
      options = {
        desc = "Next buffer";
      };
    }
  ];

  tabKeys = [
    {
      mode = "n";
      key = "<leader><tab>n";
      action = "<cmd>tabnext<cr>";
      options.desc = "Next tab";
    }
    {
      mode = "n";
      key = "<leader><tab><tab>";
      action = "<cmd>tabnext<cr>";
      options.desc = "Next tab";
    }
    {
      mode = "n";
      key = "<leader><tab>]";
      action = "<cmd>tabnext<cr>";
      options.desc = "Next tab";
    }
    {
      mode = "n";
      key = "<leader><tab>p";
      action = "<cmd>tabprev<cr>";
      options.desc = "Prev tab";
    }
    {
      mode = "n";
      key = "<leader><tab>[";
      action = "<cmd>tabprev<cr>";
      options.desc = "Prev tab";
    }
    {
      mode = "n";
      key = "<leader><tab><space>";
      action = "<cmd>wincmd T<cr>";
      options.desc = "Open in new tab";
    }
    {
      mode = "n";
      key = "<leader><tab>q";
      action = "<cmd>tabclose<cr>";
      options.desc = "Close tab";
    }
  ];
in {
  keymaps =
    winKeys
    ++ bufferKeys
    ++ tabKeys
    ++ [
      {
        mode = ["n" "i"];
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
        options.desc = "Clear highlighting";
      }
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>xa<cr>";
        options.desc = "Write all and quit";
      }
    ];
}
