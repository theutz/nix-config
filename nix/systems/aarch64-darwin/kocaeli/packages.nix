{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zsh
    tmux
    pam-reattach
  ];
}
