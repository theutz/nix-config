{
  mkShell,
  pkgs,
  ...
}:
mkShell {
  packages = [
    pkgs.gum
    pkgs.theutz.utzvim-dev
  ];

  shellHook = ''
    gum format <<EOF
      # Welcome

      ## Commands

      - \`dev\`: run utzvim in a loop for rapid development
    EOF
    alias dev="utzvim-dev"
    cd nix/packages/utzvim
  '';
}
