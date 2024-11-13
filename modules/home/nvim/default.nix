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

  nvim = with pkgs;
    if false
    then internal.utzvim
    else neovim;
in {
  inherit options;

  config = lib.mkIf cfg.enable {
    home.packages = [
      nvim
    ];

    home.sessionVariables = lib.mkMerge [
      rec {
        EDITOR = lib.mkForce (lib.getExe nvim);
        VISUAL = EDITOR;
      }
      (lib.mkIf cfg.enableManIntegration {
        MANPAGER = lib.mkForce "${lib.getExe nvim} -c +Man!";
        MANWIDTH = lib.mkForce "999";
      })
    ];
  };
}
