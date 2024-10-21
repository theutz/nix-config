{
  lib,
  config,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkForce mkOption mkMerge;
  inherit (lib.theutz.modules) getLastComponent;
  inherit (lib.attrsets) getAttrFromPath setAttrByPath;

  mod = getLastComponent ./.;
  cfg = getAttrFromPath [namespace mod] config;

  options = setAttrByPath [namespace mod] {
    enable = mkEnableOption "neovim";
    enableManIntegration = mkOption {
      description = "use neovim as man pager";
      default = true;
    };
  };
in {
  inherit options;

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.theutz.utzvim
    ];

    home.sessionVariables = mkMerge [
      {
        EDITOR = mkForce "nvim";
        VISUAL = mkForce "nvim";
      }
      (mkIf cfg.enableManIntegration {
        MANPAGER = mkForce "nvim -c +Man!";
        MANWIDTH = mkForce "999";
      })
    ];
  };
}
