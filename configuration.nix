inputs@{ pkgs, ... }: {
  system.stateVersion = 5;
  services.nix-daemon.enable = true;

  users.users.michael = {
    name = "michael";
    home = "/Users/michael";
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.systemPackages = [
    pkgs.tmux
    pkgs.pam-reattach
  ];

  programs.zsh.enable = true;

  environment.etc."pam.d/sudo_local" = {
    text = ''
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
      auth       sufficient     pam_tid.so
    '';
  };
}
