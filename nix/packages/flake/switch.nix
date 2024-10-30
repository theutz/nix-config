{
  pkgs,
  main,
  loggers,
  ...
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
        if [[ -d "$MY_FLAKE_DIR/result" ]]
        then
          info "cleaning up old builds..."
          rm -rf "$MY_FLAKE_DIR/result"
        fi

        if [[ "$(git log -1 --pretty=%B)" == "WIP" ]]
        then
          info "uncommitting WIP changes..."
          git reset HEAD~
        fi
      }

      trap cleanup EXIT

      cd "$MY_FLAKE_DIR"

      if [[ -z "$(git -c color.status=always status --short | tee /dev/tty)" ]]; then
        warn "no changes detected. Exiting..."
        exit 0
      fi

      info "creating WIP commit..."
      git add -A &&
        git commit -m "WIP"

      info "switching to new generation..."
      if darwin-rebuild switch --flake .; then
        info "profile switched"
      else
        fatal "failure while changing profile"
      fi

      current_generation="$(darwin-rebuild --list-generations | awk '/\(current\)/ {print $1}')"

      info "committing changes..."
      if git commit --amend --message "Generation $current_generation"
      then
        info "changes committed"
      else
        fatal "changes could not be committed"
      fi

      info "pushing changes"
      if git pull --rebase && git push
      then
        info "changes pushed"
      else
        fatal "changes could not be pushed"
      fi
    '';
  }
