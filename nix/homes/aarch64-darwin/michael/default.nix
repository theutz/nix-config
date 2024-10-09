{
  pkgs,
  inputs,
  system,
  ...
}: let
  unstable = inputs.unstable.legacyPackages.${system};
  utzvim = inputs.utzvim.packages.${system}.default;
in {
  home.stateVersion = "24.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "neovide --no-fork";
  };

  home.packages = with pkgs; [
    neovide
    lsix
    ripgrep
    nix-melt
    unstable.devenv
    utzvim
    theutz.txp
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
    lazygit.enable = true;
    lf.enable = true;
    prezto.autoTmux = true;
    prezto.enable = true;
    starship.enable = true;
    tmux.enable = true;
    xdg.enable = true;
    zoxide.enable = true;
    zsh.enable = true;
  };
}
