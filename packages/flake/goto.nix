{
  pkgs,
  lib,
  main,
  ...
}: let
  inherit (lib.internal.bash) loggers;
  name = "goto";
  description = "`cd` to flake config";
  usage =
    /*
    markdown
    */
    ''
      # ${main} ${name}

      ${description}.

      ## Usage

      ```bash
      ${main} ${name} [flags]
      ```

      ## Flags

      | Long   | Short | Description    |
      | :---   | :---  | :---           |
      | --help | -h    | show this help |
    '';
in
  pkgs.writeShellApplication {
    inherit name;

    meta = {
      inherit description;
    };

    runtimeInputs = with pkgs; [
      gum
    ];

    text = ''
      function help () {
        gum format <<-'EOF'
        ${usage}
      EOF
      }

      ${loggers}

      if [[ ! -v MY_FLAKE_DIR || -z "$MY_FLAKE_DIR" ]]; then
        fatal "MY_FLAKE_DIR is not set"
      fi

      if [[ ! -d "$MY_FLAKE_DIR" || ! -f "$MY_FLAKE_DIR"/flake.lock ]]; then
        fatal "$MY_FLAKE_DIR does not contain a flake"
      fi

      args=()
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --help|-h)
            help
            exit 0
            ;;
          *)
            fatal "argument not recognized: $1"
            ;;
        esac
      done
      set -- "''${args[@]}"

      info "Changing directory to $MY_FLAKE_DIR"
      cd "$MY_FLAKE_DIR"
      "$SHELL"
    '';
  }
