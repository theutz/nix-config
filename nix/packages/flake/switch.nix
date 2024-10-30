{
  pkgs,
  lib,
  main,
  loggers,
  darwin-rebuild,
  build,
}: let
  name = "switch";
  description = "Build, activate, commit, and push";
  usage =
    /*
    markdown
    */
    ''
      # ${main} ${name}

      ${description}.

      ## Usage

      ```bash
      $ ${main} ${name} [flags]
      ```

      ### Flags

      | Long   | Short | Description    |
      | :----- | :---- | :------------- |
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
      function help() {
        gum format <<-'EOF'
        ${usage}
      EOF
      }

      ${loggers}

      if [[ ! -v MY_FLAKE_DIR || -z "$MY_FLAKE_DIR" ]]; then
        fatal "MY_FLAKE_DIR not set"
      fi

      if [[ ! -d "$MY_FLAKE_DIR" ]]; then
        fatal "$MY_FLAKE_DIR is not a directory"
      fi

      if [[ ! -f "$MY_FLAKE_DIR/flake.lock" ]]; then
        fatal "$MY_FLAKE_DIR has not flake"
      fi

      args=()
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --help|-h)
            help
            exit 0
            ;;
          *)
            fatal "argument not found: $1"
            ;;
        esac
      done
      set -- "''${args[@]}"

      function cleanup () {
        cd -

        if [[ -d "$MY_FLAKE_DIR/result" ]]; then
          rm -rf "$MY_FLAKE_DIR/result"
        fi
      }

      trap cleanup EXIT

      cd "$MY_FLAKE_DIR"

      git status --short
      if gum confirm "Add all files?"; then
        git add -A
      else
        fatal "Operation cancelled."
      fi

      info "Activating flake..."
      if darwin-rebuild switch --flake .; then
        info "Flake activated"
      else
        fatal "Flake could not be activated"
      fi

      current_generation="$(darwin-rebuild --list-generations | awk '/\(current\)/ {print $1}')"

      info "Committing changes..."
      if git commit -m "Generation $current_generation"; then
        info "Changes committed"
      else
        fatal "Changes could not be committed"
      fi

      info "Pushing changes"
      if git pull --rebase && git push; then
        info "Changes pushed"
      else
        fatal "Changes could not be pushed"
      fi
    '';
  }
