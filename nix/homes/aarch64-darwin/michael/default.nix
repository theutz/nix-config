{
  lib,
  pkgs,
  inputs,
  system,
  ...
}: let
  inherit (lib) mkDefault;
  unstable = inputs.unstable.legacyPackages.${system};
in {
  home.stateVersion = "24.05";

  home.sessionVariables = {
    EDITOR = mkDefault "nvim";
    VISUAL = mkDefault "neovide --no-fork";
  };

  home.packages = with pkgs; [
    neovide
    lsix
    ripgrep
    nix-melt
    unstable.devenv
    less
  ];

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
  programs.man.enable = true;

  programs.spotify-player = {
    enable = true;
    settings = {
      device = {
        volume = 85;
      };
    };
  };

  theutz = {
    atuin.enable = true;
    bash.enable = true;
    bat.enable = true;
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
}
