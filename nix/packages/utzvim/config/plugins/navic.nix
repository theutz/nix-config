{
  lib,
  config,
  ...
}: {
  plugins.navic = {
    enable = true;
    settings = {
      lsp = {
        auto_attach = true;
      };
    };
  };

  plugins.lualine.settings.sections.lualine_c = lib.mkIf config.plugins.navic.enable ["navic"];
}
