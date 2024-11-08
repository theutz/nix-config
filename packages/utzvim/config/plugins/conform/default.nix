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
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable auto-format-on-save",
      bang = true
    })

    vim.api.nvim_create_user_command("FormatEnable", function (args)
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable auto-format-on-save",
    })
  '';

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

      format_after_save = {
        lsp_fallback = true;
      };

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
