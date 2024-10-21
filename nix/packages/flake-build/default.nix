{
  pkgs,
  lib,
  ...
}:
pkgs.writeShellApplication rec {
  name =
    lib.last
    (lib.path.subpath.components
      (lib.path.splitRoot ./.).subpath);

  meta = {
    description = "";
    longDescription = ''
      usage: ${name}
    '';
  };

  runtimeInputs = with pkgs; [
    theutz.print-path-to-flake
    git
  ];

  text = ''
    flake="$(print-path-to-flake)"
    (
      cd "$flake" &&
        git add -A &&
        darwin-rebuild switch --flake .
    )
  '';
}
