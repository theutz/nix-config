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
      doggo
      caddy
      curlie
      duckdb
      gh
      delta
      glow
      gnused
      gping
      hugo
      jq
      hurl
      httpie
      ijq
      imagemagick
      just
      lazydocker
      lnav
      mods
      mosh
      mycli
      overmind
      onefetch
      noti
      sd
      sad
      rsync
      speedtest-rs
      ssh-copy-id
      tldr
      tz
      tree
      wget
      wrk
      xdg-ninja
      yq
      yj
      sketchybar
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
      htop.enable = true;
      lazygit.enable = true;
      less.enable = true;
      lf.enable = true;
      man.enable = true;
      nushell.enable = true;
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
