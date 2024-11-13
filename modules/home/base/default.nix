{
  pkgs,
  lib,
  namespace,
  config,
  osConfig,
  ...
}: let
  mod = lib.internal.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod}.
    enable = lib.mkEnableOption "base settings for home manager";

  config = lib.mkIf cfg.enable {
    home.stateVersion = "24.05";

    home.packages =
      (import ./packages.nix {inherit pkgs;})
      ++ (lib.attrValues pkgs.internal);

    home.sessionPath = [
      "${osConfig.homebrew.brewPrefix}"
    ];

    lib.${namespace} = {
      mkOutOfStoreSymlink = path: let
        home = /. + config.home.homeDirectory;
        base = lib.internal.vars.paths.homeModules;
        mod = lib.internal.path.getLastComponent (builtins.dirOf path);
      in
        lib.pipe path [
          builtins.baseNameOf
          lib.singleton
          (lib.concat [base mod])
          lib.path.subpath.join
          (lib.path.append home)
          config.lib.file.mkOutOfStoreSymlink
        ];
    };

    internal = {
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
      jrnl.enable = true;
      lazygit.enable = true;
      less.enable = true;
      lf.enable = true;
      man.enable = true;
      nb.enable = true;
      noti.enable = true;
      nushell.enable = true;
      nvim.enable = true;
      prezto.enable = true;
      prezto.autoTmux = true;
      ripgrep.enable = true;
      starship.enable = true;
      taskwarrior.enable = true;
      tldr.enable = true;
      tmux.enable = true;
      wezterm.enable = true;
      xdg.enable = true;
      xplr.enable = true;
      yazi.enable = true;
      zk.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };
  };
}
