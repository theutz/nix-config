{
  system.stateVersion = 5;
  services.nix-daemon.enable = true;

  users.users.michael = {
    name = "michael";
    home = "/Users/michael";
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
