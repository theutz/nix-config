{pkgs, ...}:
pkgs.writeShellApplication {
  name = "utzvim-dev";

  text = ''
    while :; do
      nix run .#utzvim
    done
  '';
}
