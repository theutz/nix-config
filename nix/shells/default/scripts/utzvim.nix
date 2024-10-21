{pkgs, ...}:
pkgs.writeShellApplication {
  name = "utzvim";

  meta = {
    description = "Edit my neovim configuration while restarting on quit";
  };

  runtimeInputs = with pkgs; [
    gum
  ];

  text = ''
    while :; do
      nix run .#utzvim -- -c 'cd nix/packages/utzvim'
      if ! gum confirm "Restart?" --timeout=5s; then
        exit
      fi
    done
  '';
}
