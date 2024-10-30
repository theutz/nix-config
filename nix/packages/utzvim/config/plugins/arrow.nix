{
  lib,
  config,
  helpers,
  ...
}: {
  plugins.arrow = {
    enable = true;
    settings = {
      show_icons = true;
      leader_key = "-";
      always_show_path = true;
    };
  };

  plugins.lualine.settings.sections = lib.mkIf config.plugins.arrow.enable {
    lualine_x = ["require'arrow.statusline'.text_for_statusline_with_icons()"];
  };
}
