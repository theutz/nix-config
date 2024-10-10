{
  plugins.navic = {
    enable = true;
    settings = {
      lsp = {
        auto_attach = true;
      };
    };
  };

  plugins.lualine.settings.sections.lualine_c = ["navic"];
}
