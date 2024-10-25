{
  lib,
  pkgs,
  ...
}: {
  plugins.lsp = {
    enable = true;

    keymaps = {
      extra = [
        {
          mode = "n";
          action = "<cmd>LspStop<cr>";
          key = "<leader>cX";
          options.desc = "Stop LSP Servers";
        }
        {
          mode = "n";
          action = "<cmd>LspStart<cr>";
          key = "<leader>cs";
          options.desc = "Start LSP Servers";
        }
        {
          mode = "n";
          action = "<cmd>LspRestart<cr>";
          key = "<leader>cx";
          options.desc = "Restart LSP Servers";
        }
        {
          mode = "n";
          action = "<cmd>LspInfo<cr>";
          key = "<leader>ci";
          options.desc = "Lsp Info";
        }
        {
          key = "]e";
          action.__raw =
            /*
            lua
            */
            ''
              function ()
                vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
              end
            '';
          options.desc = "Next error";
        }
        {
          key = "[e";
          action.__raw =
            /*
            lua
            */
            ''
              function ()
                vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
              end
            '';
          options.desc = "Prev error";
        }

        {
          key = "]w";
          action.__raw =
            /*
            lua
            */
            ''
              function ()
                vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
              end
            '';
          options.desc = "Next warning";
        }

        {
          key = "[w";
          action.__raw =
            /*
            lua
            */
            ''
              function ()
                vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
              end
            '';
          options.desc = "Prev warning";
        }

        {
          key = "]d";
          action.__raw =
            /*
            lua
            */
            ''
              function ()
                vim.diagnostic.goto_next({ severity = {vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT} })
              end
            '';
          options.desc = "Next diagnostic";
        }

        {
          key = "[d";
          action.__raw =
            /*
            lua
            */
            ''
              function ()
                vim.diagnostic.goto_prev({ severity = {vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT} })
              end
            '';
          options.desc = "Prev diagnostic";
        }
      ];

      lspBuf = {
        K = {
          action = "hover";
          desc = "Show Documentation";
        };
        gD = {
          action = "references";
          desc = "Goto References";
        };
        gd = {
          action = "definition";
          desc = "Goto Definition";
        };
        gi = {
          action = "implementation";
          desc = "Goto Implementation";
        };
        gy = {
          action = "type_definition";
          desc = "Goto Type Definition";
        };
        "<leader>ca" = {
          action = "code_action";
          desc = "Code action";
        };
        "<leader>cr" = {
          action = "rename";
          desc = "Rename";
        };
      };
    };

    servers = {
      antlersls = {
        enable = false;
      };

      awk_ls = {
        enable = false;
      };

      nixd = {
        enable = false;
      };

      ansiblels = {
        enable = true;
      };

      bashls = {
        enable = true;
      };

      css_variables = {
        enable = true;
        package = pkgs.vscode-langservers-extracted;
      };

      cssls = {
        enable = true;
      };

      diagnosticls = {
        enable = true;
      };

      docker_compose_language_service = {
        enable = true;
      };

      dockerls = {
        enable = true;
      };

      emmet_language_server = {
        enable = true;
      };

      eslint = {
        enable = true;
      };

      golangci_lint_ls = {
        enable = true;
      };

      gopls = {
        enable = true;
      };

      graphql = {
        enable = true;
      };

      html = {
        enable = true;
      };

      intelephense = {
        enable = true;
        package = pkgs.intelephense;
      };

      jqls = {
        enable = true;
      };

      jsonls = {
        enable = true;
      };

      lua_ls = {
        enable = true;
      };

      marksman = {
        enable = true;
      };

      nginx_language_server = {
        enable = true;
      };

      nil_ls = {
        enable = true;
      };

      nushell = {
        enable = true;
      };

      ruby_lsp = {
        enable = true;
      };

      sqlls = {
        enable = true;
        package = pkgs.sqls;
      };

      stylelint_lsp = {
        enable = true;
      };

      tailwindcss = {
        enable = true;
      };

      taplo = {
        enable = true;
      };

      ts_ls = {
        enable = true;
      };

      yamlls = {
        enable = true;
      };
    };
  };
}
