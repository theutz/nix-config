{...}: {
  opts = {
    expandtab = true;
    foldlevel = 20;
    foldmethod = "indent";
    ignorecase = true;
    list = true;
    listchars = "tab:>-,multispace:·,trail:·,extends:…,precedes:…";
    mouse = "a";
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    smartcase = true;
    smartindent = true;
    smarttab = true;
    splitbelow = true;
    splitright = true;
    swapfile = false;
    tabstop = 2;
  };

  autoGroups = {
    resize = {clear = true;};
  };

  autoCmd = [
    {
      command = "wincmd =";
      event = "VimResized";
      pattern = ["*"];
      group = "resize";
      desc = "Resize windows when vim is resized";
    }
  ];
}
