{
  lib,
  pkgs,
  ...
}:
pkgs.writeShellApplication rec {
  name = lib.last (lib.path.subpath.components (lib.path.splitRoot ./.).subpath);

  meta = {
    description = "get the path to my local flake / nix setup";
    longDescription = ''
      ${meta.description}

      usage: ${name}

      flags:
        --help, -h        show this help
    '';
  };

  text = ''
    help () {
      cat <<'EOF'
    ${meta.longDescription}
    EOF
    }

    while [[ $# -gt 0 ]]; do
      case $1 in
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

    if [[ -z "$HOME" ]]; then
      print "\$HOME not set";
      exit 1
    fi

    flake_path="${lib.theutz.vars.paths.flake}"

    if [[ -z "$flake_path" ]]; then
      print "Flake path set incorrectly."
      exit 1
    fi

    printf "%s/%s\n" "$HOME" "$flake_path"
  '';
}
