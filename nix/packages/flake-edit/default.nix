{
  lib,
  pkgs,
  ...
}:
pkgs.writeShellApplication rec {
  name = lib.last (lib.path.subpath.components (lib.path.splitRoot ./.).subpath);

  meta = rec {
    description = "edit my local flake configuration";
    longDescription = ''
      ${description}

      usage: ${name} [paths...]

      flags:
        --help, -h:        show this help
    '';
  };

  runtimeInputs = with pkgs; [
    gum
    theutz.print-path-to-flake
  ];

  text = ''
    help () {
      cat <<-EOF
    ${meta.longDescription}
    vars:
      flake path: $(print-path-to-flake)
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
          ;;
      esac
    done

    while :; do
      (
        cd "$(print-path-to-flake)"
        nix run .#utzvim
        if ! gum confirm "Do you want to restart the editor?" --timeout=5s; then
          if gum confirm "Do you want to rebuild your system?" --timeout=5s; then
            flake-build
          fi

          exit
        fi
      )
    done
  '';
}
