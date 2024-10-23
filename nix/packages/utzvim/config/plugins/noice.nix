{
  config,
  lib,
  ...
}: {
  plugins.noice = {
    enable = true;
    routes = [
      {
        view = "notify";
        filter = {event = "msg_showmode";};
      }
    ];
  };

  keymaps = lib.mkMerge [
    (lib.mkIf config.plugins.noice.enable [
      {
        mode = "n";
        key = "<leader>ln";
        action = "<cmd>NoiceAll<cr>";
        options.desc = "Notifications";
      }
    ])
    (lib.mkIf config.plugins.fzf-lua.enable [
      {
        mode = "n";
        key = "<leader>sn";
        action = "<cmd>Noice fzf<cr>";
        options.desc = "Notifications";
      }
    ])
  ];
}
