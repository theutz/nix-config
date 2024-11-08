{
  pkgs,
  lib,
  ...
}: let
  shellFormatters =
    lib.genAttrs
    ["bash" "sh" "zsh"]
    (_: ["shellcheck" "shellharden" "shfmt"]);
in {
  extraConfigLua = ''
    vim.api.nvim_create_user_command("FormatDisable", function (args)
      if args.bang then
        vim.b.disable_autoformat = true
        print("Disabled auto-format for buffer")
      else
        vim.g.disable_autoformat = true
        print("Disabled auto-format globally")
      end
    end, {
      desc = "Disable auto-format-on-save",
      bang = true
    })

    vim.api.nvim_create_user_command("FormatEnable", function (args)
      if args.bang then
        vim.b.disable_autoformat = false
        print "Re-enabled auto-format for buffer"
      else
        vim.g.disable_autoformat = false
        print "Re-enabled auto-format globally"
      end
    end, {
      desc = "Re-enable auto-format-on-save",
      bang = true
    })

    vim.api.nvim_create_user_command("FormatToggle", function (args)
      if args.bang then
        if vim.b.disable_autoformat then
          -- vim.api.nvim_call_function("FormatEnable!", {})
          vim.cmd[[FormatEnable!]]
        else
          -- vim.api.nvim_call_function("FormatDisable!", {})
          vim.cmd[[FormatDisable!]]
        end
      else
        if vim.g.disable_autoformat then
          -- vim.api.nvim_call_function("FormatEnable", {})
          vim.cmd[[FormatEnable]]
        else
          -- vim.api.nvim_call_function("FormatDisable", {})
          vim.cmd[[FormatDisable]]
        end
      end
    end, {
      desc = "Toggle auto-format-on-save",
      bang = true
    })
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>FormatToggle!<cr>";
      options.desc = "Toggle formatting (buffer)";
    }
    {
      mode = "n";
      key = "<leader>tF";
      action = "<cmd>FormatToggle<cr>";
      options.desc = "Toggle formatting (global)";
    }
  ];

  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft =
        shellFormatters
        // {
          nix = [
            "alejandra"
          ];

          yaml = [
            "prettier"
          ];
        };

      format_on_save.__raw =
        /*
        lua
        */
        ''
          function (bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
          end
        '';

      formatters = {
        alejandra = {
          command = lib.getExe pkgs.alejandra;
        };

        shellcheck = {
          command = lib.getExe pkgs.shellcheck;
        };

        shfmt = {
          command = lib.getExe pkgs.shfmt;
        };

        shellharden = {
          command = lib.getExe pkgs.shellharden;
        };
      };
    };
  };
}
