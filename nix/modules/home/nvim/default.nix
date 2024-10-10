{
  lib,
  config,
  namespace,
  inputs,
  system,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkForce mkOption mkMerge;
  inherit (lib.theutz) getLastComponent;
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

  utzvim = inputs.utzvim.packages.${system}.default;
in {
  inherit options;

  config = mkIf cfg.enable {
    home.packages = [
      utzvim
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
