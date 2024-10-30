{
  config,
  lib,
  ...
}: {
  plugins.noice = {
    enable = true;
    presets = {
      bottom_search = true;
      command_palette = true;
      long_message_to_split = true;
      inc_rename = true;
    };
    # cmdline = {
    # view = "cmdline";
    # format = {
    #   search_down = {view = "cmdline";};
    #   search_up = {view = "cmdline";};
    # };
    # };
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
