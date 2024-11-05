{
  lib,
  config,
  ...
}: {
  plugins.nvim-surround = {
    enable = true;
    settings = {
      keymaps = {
        normal = "gsa";
        normal_cur = "gsl";
        normal_line = "gsm";
        normal_cur_line = "gsL";
        visual = "gs";
        visual_line = "gS";
        delete = "gsd";
        change = "gsr";
        change_line = "gsR";
      };
    };
  };

  keymaps = lib.mkIf config.plugins.nvim-surround.enable [];
}
