{
  pkgs,
  lib,
  namespace,
  ...
}: let
  mod = "base";
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "base settings for home manager";
  };

  config = {
    home.stateVersion = "24.05";

    home.packages = with pkgs; [
      neovide
      lsix
      ripgrep
      nix-melt
      devenv
      less
    ];

    theutz = {
      atuin.enable = true;
      bash.enable = true;
      bat.enable = true;
      comma.enable = true;
      direnv.enable = true;
      eza.enable = true;
      fish.enable = true;
      fzf.enable = true;
      lazygit.enable = true;
      less.enable = true;
      lf.enable = true;
      man.enable = true;
      nvim.enable = true;
      prezto = {
        enable = true;
        autoTmux = true;
      };
      starship.enable = true;
      tmux.enable = true;
      xdg.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };
  };
}
