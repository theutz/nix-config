{...}: {
  opts = {
    number = true;
    relativenumber = true;
    splitright = true;
    splitbelow = true;
    swapfile = false;
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    smartcase = true;
    ignorecase = true;
    smarttab = true;
    smartindent = true;
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
