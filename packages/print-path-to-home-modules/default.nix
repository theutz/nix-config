{
  lib,
  pkgs,
  namespace,
  ...
}:
pkgs.writeShellApplication rec {
  name = lib.last (lib.path.subpath.components (lib.path.splitRoot ./.).subpath);

  meta = {
    description = "print path to home modules in my nix config";
    longDescription = ''
      usage: ${name}

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
    ${meta.description}

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

    printf "%s/${lib.${namespace}.vars.paths.homeModules}\n" "$HOME"
  '';
}
