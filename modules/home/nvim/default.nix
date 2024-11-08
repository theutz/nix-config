{
  lib,
  config,
  namespace,
  pkgs,
  ...
}: let
  mod = lib.internal.path.getLastComponent ./.;
  cfg = lib.getAttrFromPath [namespace mod] config;

  options = lib.setAttrByPath [namespace mod] {
    enable = lib.mkEnableOption "neovim";
    enableManIntegration = lib.mkOption {
      description = "use neovim as man pager";
      default = true;
    };
  };
in {
  inherit options;

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      internal.utzvim
    ];

    home.sessionVariables = lib.mkMerge [
      {
        EDITOR = lib.mkForce "nvim";
        VISUAL = lib.mkForce "nvim";
      }
      (lib.mkIf cfg.enableManIntegration {
        MANPAGER = lib.mkForce "nvim -c +Man!";
        MANWIDTH = lib.mkForce "999";
      })
    ];
  };
}
