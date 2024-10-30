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
        cd -

        if [[ -d "$MY_FLAKE_DIR/result" ]]
        then
          rm -rf "$MY_FLAKE_DIR/result"
        fi

        if [[ "$(git log -1 --pretty=%B)" == "WIP" ]]
        then
          git reset HEAD~
        fi
      }

      trap cleanup EXIT

      cd "$MY_FLAKE_DIR"

      if [[ -z "$(git -c color.status=always status --short | tee /dev/tty)" ]]; then
        warn "No changes detected. Exiting..."
        exit 0
      fi

      if gum confirm "Add all files?"
      then
        git add -A &&
          git commit -m "WIP"
      else
        fatal "Operation cancelled."
      fi

      info "Switching to new generation..."
      if darwin-rebuild switch --flake .; then
        info "Profile switched"
      else
        fatal "Failure while changing profile"
      fi

      current_generation="$(darwin-rebuild --list-generations | awk '/\(current\)/ {print $1}')"

      info "Committing changes..."
      if git commit --amend --message "Generation $current_generation"
      then
        info "Changes committed"
      else
        fatal "Changes could not be committed"
      fi

      info "Pushing changes"
      if git pull --rebase && git push
      then
        info "Changes pushed"
      else
        fatal "Changes could not be pushed"
      fi
    '';
  }
