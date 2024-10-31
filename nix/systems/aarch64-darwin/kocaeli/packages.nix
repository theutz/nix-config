{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bashInteractive
    zsh
    tmux
    pam-reattach
  ];
}
