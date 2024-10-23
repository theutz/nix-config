{
  config,
  lib,
  ...
}: let
  cfg = config.plugins.grug-far;
in {
  plugins.grug-far = {
    enable = true;
  };

  keymaps = lib.mkIf cfg.enable [
    {
      mode = "n";
      key = "<leader>sg";
      action = "<cmd>GrugFar<cr>";
      options.desc = "Search & Replace [Grug]";
    }
  ];
}
