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
      nix-melt
      devenv
      watchexec
      age
    ];

    theutz = {
      atuin.enable = false;
      bash.enable = true;
      bat.enable = true;
      broot.enable = true;
      btop.enable = true;
      comma.enable = true;
      darwin-defaults.enable = true;
      direnv.enable = true;
      eza.enable = true;
      fd.enable = true;
      fish.enable = true;
      fzf.enable = true;
      go.enable = true;
      lazygit.enable = true;
      less.enable = true;
      lf.enable = true;
      man.enable = true;
      nvim.enable = true;
      prezto = {
        enable = true;
        autoTmux = true;
      };
      ripgrep.enable = true;
      starship.enable = true;
      tmux.enable = true;
      wezterm.enable = true;
      xdg.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };
  };
}
