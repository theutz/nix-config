{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption mod;
    package = lib.mkPackageOption pkgs "neovim" {};
    enableManIntegration = lib.mkOption {
      description = "use neovim as man pager";
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
    home.sessionVariables = lib.mkMerge [
      {
        EDITOR = lib.mkForce cfg.package;
        VISUAL = lib.getExe pkgs.neovide;
      }
      (lib.mkIf cfg.enableManIntegration {
        MANPAGER = lib.mkForce (lib.trace "manly" "${lib.getExe cfg.package} -c +Man!");
        MANWIDTH = lib.mkForce "999";
      })
    ];
  };
}
