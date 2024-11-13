{pkgs, ...}: let
  php = pkgs.php83.buildEnv {
    extensions = {
      enabled,
      all,
    }:
      enabled
      ++ (with all; [
        redis
      ]);
  };
in
  with pkgs; [
    _1password
    _1password-gui
    act
    age
    bats
    bruno
    caddy
    cargo
    clolcat
    coreutils
    csvlens
    curl
    curlie
    delta
    devenv
    doggo
    duckdb
    duf
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
    jq
    just
    lazydocker
    lazysql
    lesspipe
    litecli
    lnav
    lsix
    maple-mono-NF
    mods
    moreutils
    mosh
    mycli
    nerdfonts
    nixd
    nix-melt
    nix-prefetch-git
    nodejs
    noti
    nurl
    openai
    overmind
    php83
    php83.packages.composer
    pls
    pnpm
    procs
    python3
    rainfrog
    redis
    rsync
    ruby
    sad
    sd
    speedtest-go
    ssh-copy-id
    statix
    tidy-viewer
    tig
    tree
    tz
    watchexec
    wget
    wrk
    xdg-ninja
    yj
    yq
  ]
