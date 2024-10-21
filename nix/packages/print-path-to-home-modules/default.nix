{
  lib,
  pkgs,
  ...
}:
pkgs.writeShellApplication rec {
  name = lib.last (lib.path.subpath.components (lib.path.splitRoot ./.).subpath);

  meta = rec {
    description = "print the path to the home modules directory in my local flake";
    longDescription = ''
      ${description}

      usage: print-path-to-home-modules

      flags:
          --help, -h        show this help
    '';
  };

  runtimeInputs = with pkgs; [
    theutz.print-path-to-flake
  ];

  text = ''
    help () {
      cat <<'EOF'
    ${meta.longDescription}
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

    printf "%s/${lib.theutz.vars.paths.homeModules}\n" "$HOME"
  '';
}
