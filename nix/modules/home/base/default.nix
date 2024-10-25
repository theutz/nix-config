{
  pkgs,
  lib,
  namespace,
  config,
  ...
}: let
  mod = lib.pipe ./. [
    lib.path.splitRoot
    (lib.getAttr "subpath")
    lib.path.subpath.components
    lib.last
  ];
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "base settings for home manager";
  };

  config = lib.mkIf cfg.enable {
    home.stateVersion = "24.05";

    home.packages =
      (with pkgs; [
        _1password
        _1password-gui
        act
        age
        bats
        bruno
        caddy
        clolcat
        coreutils
        csvlens
        curl
        curlie
        delta
        devenv
        doggo
        duckdb
        figlet
        fortune-kind
        fpp
        gh
        git
        glow
        gnused
        gnupg
        gping
        httpie
        htop
        hugo
        hurl
        ijq
        imagemagick
        inkscape
        jankyborders
        jq
        just
        lazydocker
        lazygit
        lazysql
        less
        lesspipe
        litecli
        lnav
        lsix
        maple-mono-NF
        mods
        mosh
        mycli
        neovide
        nerdfonts
        nixd
        nix-melt
        nodejs
        noti
        onefetch
        overmind
        php83Packages.composer
        procs
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
      xplr.enable = true;
      yazi.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };
  };
}
