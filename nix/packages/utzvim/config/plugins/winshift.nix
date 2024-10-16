{pkgs, ...}: {
  extraPlugins = [
    pkgs.vimPlugins.winshift-nvim
  ];

  keymaps =
    (builtins.map (key: {
      inherit key;
      mode = "n";
      action = "<Cmd>WinShift<cr>";
      options.desc = "Move window";
    }) ["<leader>wm" "<C-w>m"])
    ++ (builtins.map (key: {
      inherit key;
      mode = "n";
      action = "<Cmd>WinShift swap<cr>";
      options.desc = "Swap window";
    }) ["<leader>wM" "<C-w>M"]);
}
