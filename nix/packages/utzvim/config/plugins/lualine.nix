{
  plugins.lualine = {
    enable = true;
    settings = {
      sections = {
        lualine_b = [
          "filename"
        ];
        lualine_x = [
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
        lualine_y = [
          "diff"
        ];
        lualine_z = [
          "branch"
        ];
      };
    };
  };
}
