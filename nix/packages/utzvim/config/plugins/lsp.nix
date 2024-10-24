{
  lib,
  pkgs,
  ...
}: {
  plugins.none-ls = {
    enable = false;
    sources = {
      code_actions = {
        gitrebase.enable = true;
        gitsigns.enable = true;
        proselint.enable = true;
        refactoring.enable = true;
        statix.enable = true;
        textlint.enable = true;
        textlint.package = pkgs.textlint;
      };
      diagnostics = {
        codespell.enable = true;
        commitlint.enable = true;
        deadnix.enable = true;
        dotenv_linter.enable = true;
        editorconfig_checker.enable = true;
        gitlint.enable = true;
        golangci_lint.enable = true;
        markdownlint.enable = true;
        phpstan.enable = true;
        proselint.enable = true;
        rubocop.enable = true;
        selene.enable = true;
        statix.enable = true;
        stylelint.enable = true;
        textlint.enable = true;
        textlint.package = pkgs.textlint;
        todo_comments.enable = true;
        trail_space.enable = true;
        yamllint.enable = true;
        zsh.enable = true;
      };
      hover = {
        dictionary.enable = true;
      };
    };
  };

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

    servers =
      (lib.genAttrs [
        "ansiblels"
        # "antlersls"
        # "awk_ls"
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
        "nixd"
        "nushell"
        "ruby_lsp"
        "sqlls"
        "stylelint_lsp"
        "tailwindcss"
        "taplo"
        "ts_ls"
        "yamlls"
      ] (name: {enable = true;}))
      // {
        css_variables.package = pkgs.vscode-langservers-extracted;
        intelephense.package = pkgs.intelephense;
        sqlls.package = pkgs.sqls;
      };
  };
}
