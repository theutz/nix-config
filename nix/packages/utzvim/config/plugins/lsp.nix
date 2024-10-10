{
  plugins.lsp = {
    enable = true;

    keymaps = {
      diagnostic = {
        "]e" = "goto_next";
        "[e" = "goto_prev";
      };

      lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
      };
    };

    servers = {
      nil_ls = {
        enable = true;
      };
      jsonls = {
        enable = true;
      };
      yamlls = {
        enable = true;
      };
    };
  };
}
