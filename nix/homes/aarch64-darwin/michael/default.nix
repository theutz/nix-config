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
  ];

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  theutz = {
    atuin.enable = true;
    bash.enable = true;
    bat.enable = true;
    direnv.enable = true;
    eza.enable = true;
    fish.enable = true;
    lazygit.enable = true;
    lf.enable = false;
    prezto.autoTmux = true;
    prezto.enable = true;
    starship.enable = true;
    tmuxp.enable = true;
    xdg.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
    zsh.enable = true;
  };
}
