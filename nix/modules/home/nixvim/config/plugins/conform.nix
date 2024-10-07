{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        bash = ["shellcheck" "shellharden" "shfmt"];
        nix = ["alejandra"];
        yaml = ["prettier"];
      };
      format_on_save = {
        lsp_fallback = true;
        timeout_ms = 500;
      };
      format_after_save = {
        lsp_fallback = true;
      };
    };
  };
}
