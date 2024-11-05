{
  pkgs,
  lib,
  config,
  namespace,
  ...
}: let
  mod = lib.internal.path.getLastComponent ./.;
  cfg = config.internal.${mod};
in {
  options.internal.${mod} = {
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
