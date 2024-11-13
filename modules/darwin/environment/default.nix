{
  pkgs,
  lib,
  config,
  namespace,
  ...
}: let
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption mod;
  };

  config = {
    environment = lib.mkIf cfg.enable {
      systemPackages = with pkgs; [
        bashInteractive
        tmux
        pam-reattach
      ];

      shells = with pkgs; [
        bashInteractive
        zsh
      ];

      etc."pam.d/sudo_local" = {
        text = ''
          auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
          auth       sufficient     pam_tid.so
        '';
      };
    };
  };
}
