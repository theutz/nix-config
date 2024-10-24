{
  plugins.lualine = {
    enable = true;
    settings = {
      sections = {
        lualine_c = [
          {
            __raw = ''
              {
                require("noice").api.statusline.mode.get,
                cond = require("noice").api.statusline.mode.has,
                color = { fg = "#ff9e64" },
              }
            '';
          }
        ];
      };
    };
  };
}
