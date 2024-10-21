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
    description = "rebuild my system from my local flake";
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

    function help () {
      cat <<-EOF
    ${meta.description}

    ${meta.longDescription}
    vars:
      flake path: ''${flake}
    EOF
    }

    while [[ $# -gt 0 ]]; do
      case "$1" in
        --help|-h)
          help
          exit 0
          ;;
        *)
          help
          exit 1
      esac
    done

    (
      cd "$flake" &&
        git add -A &&
        darwin-rebuild switch --flake .
    )
  '';
}
