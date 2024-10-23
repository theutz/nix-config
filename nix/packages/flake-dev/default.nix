{
  pkgs,
  lib,
  ...
}:
pkgs.writeShellApplication rec {
  name = lib.last (lib.path.subpath.components (lib.path.splitRoot ./.).subpath);

  meta = {
    description = "attempt to rebuild the system on each change";
    longDescription = ''
      usage: ${name}
    '';
  };

  runtimeInputs =
    (
      with pkgs; [
        watchexec
        bash
      ]
    )
    ++ (with pkgs.theutz; [
      flake-build
    ]);

  text = ''
    function help() {
      cat <<-'EOF'
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

    watchexec --restart --clear --notify -- flake-build
  '';
}
