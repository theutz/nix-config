{
  pkgs,
  inputs,
  target,
  ...
}: let
  unstable = inputs.unstable.legacyPackages."${target}";
in {
  home.stateVersion = "24.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "neovide --no-fork";
  };

  home.packages = with pkgs; [
    neovide
    unstable.neovim
    lsix
    ripgrep
    nix-melt
  ];

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  theutz = {
    atuin.enable = true;
    bash.enable = true;
    bat.enable = true;
    eza.enable = true;
    fish.enable = true;
    lazygit.enable = true;
    lf.enable = true;
    neovim.enable = true;
    prezto.autoTmux = true;
    prezto.enable = true;
    starship.enable = true;
    xdg.enable = true;
    zoxide.enable = true;
    zsh.enable = true;
  };
}
