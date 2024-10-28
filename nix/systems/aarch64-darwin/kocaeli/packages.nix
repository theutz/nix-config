{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    tmux
    pam-reattach
  ];
}
