{lib, ...}: let
  inherit (lib) mkDefault;
in {
  home.stateVersion = "24.05";

  home.sessionVariables = {
    EDITOR = mkDefault "nvim";
    VISUAL = mkDefault "nvim";
  };
}
