{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = true;
      sync_frequency = "1h";
      filter_mode = "session";
      filter_mode_shell_up_keybinding = "session";
      style = "compact";
      inline_height = 10;
      enter_accept = false;
      keymap_mode = "vim-normal";
    };
  };
}
