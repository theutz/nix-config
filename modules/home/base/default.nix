{
  pkgs,
  lib,
  namespace,
  config,
  osConfig,
  ...
}: let
  mod = lib.pipe ./. [
    lib.path.splitRoot
    (lib.getAttr "subpath")
    lib.path.subpath.components
    lib.last
  ];
  cfg = config.internal.${mod};
in {
  options.internal.${mod} = {
    enable = lib.mkEnableOption "base settings for home manager";
  };

  config = lib.mkIf cfg.enable {
    home.stateVersion = "24.05";

    home.packages =
      (import ./packages.nix {inherit pkgs;})
      ++ (lib.attrValues pkgs.internal);

    home.sessionPath = [
      "${osConfig.homebrew.brewPrefix}"
    ];

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
