{
  pkgs,
  system,
  inputs,
  ...
}: {
  system.stateVersion = 5;
  services.nix-daemon.enable = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "michael"];
  };
  nix.nixPath = "nixpkgs=flake:nixpkgs";

  environment.systemPackages = with pkgs; [
    tmux
    pam-reattach
    snowfallorg.flake
  ];

  programs.zsh.enable = true;

  environment.etc."pam.d/sudo_local" = {
    text = ''
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
      auth       sufficient     pam_tid.so
    '';
  };
}
