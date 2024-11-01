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
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "base settings for home manager";
  };

  config = lib.mkIf cfg.enable {
    home.stateVersion = "24.05";

    home.packages =
      (import ./packages.nix {inherit pkgs;})
      ++ (lib.attrValues pkgs.theutz);

    home.sessionPath = [
      "${osConfig.homebrew.brewPrefix}"
    ];

    home.sessionVariables = rec {
      OPENAI_KEY = "$(op --account theutz.1password.com item get --fields credential)";
      OPENAI_API_KEY = OPENAI_KEY;
    };

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
