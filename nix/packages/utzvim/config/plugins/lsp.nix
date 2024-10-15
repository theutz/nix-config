{lib, ...}: {
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
        gy = "type_definition";
      };
    };

    servers = lib.genAttrs [
      "ansiblels"
      "antlersls"
      "awk_ls"
      "bashls"
      "css_variables"
      "cssls"
      "diagnosticls"
      "docker_compose_language_service"
      "dockerls"
      "emmet_language_server"
      "eslint"
      "golangci_lint_ls"
      "gopls"
      "graphql"
      "html"
      "intelephense"
      "jqls"
      "jsonls"
      "lua_ls"
      "marksman"
      "nginx_language_server"
      "nil_ls"
      "nushell"
      "ruby_lsp"
      "sqlls"
      "statix"
      "stylelint_lsp"
      "tailwindcss"
      "taplo"
      "ts_ls"
      "yamlls"
    ] (name: {enable = true;});
  };
}
