{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.plugins.spectre;
  inherit (lib) mkIf mkMerge;
in {
  plugins.spectre = {
    enable = false;
    findPackage = pkgs.ripgrep;
    replacePackage = pkgs.gnused;
  };

  keymaps = mkMerge [
    (mkIf cfg.enable [
      {
        mode = "n";
        key = "<leader>sR";
        action = "<cmd>Spectre<cr>";
        options.desc = "Search & Replace";
      }
    ])
  ];
}
