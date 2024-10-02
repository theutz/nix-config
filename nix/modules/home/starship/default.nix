_: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      directory = {
        truncate_to_repo = true;
        fish_style_pwd_dir_length = 2;
      };
      sudo = {
        disabled = false;
      };
    };
  };
}
