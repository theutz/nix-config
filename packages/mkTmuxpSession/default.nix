{
  pkgs,
  lib,
  namespace,
  ...
}:
pkgs.writeShellApplication rec {
  name = lib.last (lib.path.subpath.components (lib.path.splitRoot ./.).subpath);

  meta = {
    description = "create a tmuxp session file";
    longDescription = ''
      usage: ${name}

      flags:
        --help, -h        show this help
    '';
  };

  runtimeInputs = with pkgs; [
    gum
  ];

  text = ''
    function help () {
      cat <<-'EOF'
    ${meta.description}

    ${meta.longDescription}
    EOF
    }

    session_name=""

    while [[ $# -gt 0 ]]; do
      case "$1" in
        --help|-h)
          help
          exit 1
          ;;
        *)
          session_name="$1"
          break
      esac
    done

    if [[ -z "$session_name" ]]; then
      session_name="$(gum input --header "What's the session name?")"
    fi

    if [[ -z "$session_name" ]]; then
      exit 1
    fi

    file="$HOME/${lib.${namespace}.vars.paths.tmuxp}/$session_name.yml"

    "$EDITOR" "$file"
  '';
}
