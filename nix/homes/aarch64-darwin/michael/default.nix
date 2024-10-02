{ pkgs, inputs, target, ... }: let
  unstable = inputs.unstable.legacyPackages."${target}";
in {
  home.stateVersion = "24.05";
  
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "neovide";
  };

  home.packages = with pkgs; [
    neovide
    unstable.neovim
  ];
}
