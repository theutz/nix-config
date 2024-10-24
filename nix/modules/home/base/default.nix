{
  pkgs,
  lib,
  namespace,
  config,
  ...
}: let
  mod = lib.pipe ./. [lib.path.splitRoot (lib.getAttr "subpath") lib.path.subpath.components lib.last];
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "base settings for home manager";
  };

  config = lib.mkIf cfg.enable {
    home.stateVersion = "24.05";

    home.packages =
      (with pkgs; [
        age
        caddy
        coreutils
        curl
        curlie
        delta
        devenv
        doggo
        duckdb
        gh
        glow
        gnused
        gping
        httpie
        hugo
        hurl
        ijq
        imagemagick
        jq
        just
        lazydocker
        lnav
        lsix
        mods
        mosh
        mycli
        neovide
        nixd
        nix-melt
        noti
        onefetch
        overmind
        rsync
        sad
        sd
        speedtest-rs
        ssh-copy-id
        statix
        tldr
        tree
        tz
        watchexec
        wget
        wrk
        xdg-ninja
        yj
        yq
      ])
      ++ (lib.attrValues pkgs.theutz);

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
      noti.enable = true;
      nushell.enable = true;
      nvim.enable = true;
      prezto.enable = true;
      prezto.autoTmux = true;
      ripgrep.enable = true;
      sketchybar.enable = true;
      starship.enable = true;
      tmux.enable = true;
      wezterm.enable = true;
      xdg.enable = true;
      yazi.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };
  };
}
