{ pkgs, inputs, target, ... }: let
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
  ];

  theutz = {
    atuin.enable = true;
    bash.enable = true;
    bat.enable = true;
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
