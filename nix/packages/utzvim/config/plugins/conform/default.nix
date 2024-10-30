{
  pkgs,
  lib,
  ...
}: let
  shellFormatters =
    lib.genAttrs
    ["bash" "sh" "zsh"]
    (lang: ["shellcheck" "shellharden" "shfmt"]);
in {
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

      format_on_save = {
        lsp_fallback = true;
        timeout_ms = 500;
      };

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
