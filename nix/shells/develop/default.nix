{
  mkShell,
  pkgs,
  ...
}:
mkShell {
  packages = with pkgs; [
    gum
    theutz.up
  ];

  shellHook = ''
    gum format <<EOF
      # Welcome to Flake Nirvana

      Use the \`up\` command to start the dev server.
    EOF
  '';
}
