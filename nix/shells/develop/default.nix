{
  mkShell,
  pkgs,
  ...
}:
mkShell {
  packages = with pkgs; [
    gum
  ];

  shellHook = ''
    gum format "boo";
  '';
}
