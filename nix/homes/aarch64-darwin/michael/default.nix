{
  pkgs,
  inputs,
  target,
  system,
  ...
}: let
  unstable = inputs.unstable.legacyPackages.${system};
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
    inputs.Neve.packages.${system}.default
    unstable.devenv
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
    lf.enable = true;
    prezto.autoTmux = true;
    prezto.enable = true;
    starship.enable = true;
    xdg.enable = true;
    zoxide.enable = true;
    zsh.enable = true;
  };
}
