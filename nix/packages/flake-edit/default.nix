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
    paths=()

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
        --*|-*)
          help
          exit 1
          ;;
        *)
          paths+=("$(print-path-to-flake)/$1")
      esac
    done

    if [[ "''${#paths[@]}" == 0 ]]; then
      paths=("$(print-path-to-flake)")
    fi

    function cleanup () {
      cd -
    }

    trap cleanup EXIT

    while :; do
      cd "$(print-path-to-flake)"
      printf "opening nvim with paths: %s" "''${paths[@]}"
      nix run .#utzvim -- "''${paths[@]}"
      nvimExitCode="$?"
      if ! gum confirm "Restart?" --timeout=5s; then
        exit "$nvimExitCode"
      fi
    done
  '';
}
