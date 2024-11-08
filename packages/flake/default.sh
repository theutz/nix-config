
      MY_FLAKE_DIR="$HOME/${lib.internal.vars.paths.flake}"
      export MY_FLAKE_DIR

      function help () {
        gum format <<-'EOF'
        ${usage}
      EOF
      }

      "${lib.internal.bash.loggers}"

      while [[ $# -gt 0 ]]; do
        case "$1" in
          --help|-h)
            help
            exit 0
            ;;
          build|switch|goto|watch)
            action="$1"
            shift 1
            ;;
          *)
            fatal "$1: command not found"
            ;;
        esac
      done

      if [[ ! -v action ]]; then
        error "no subcommand provided"
        fatal exiting
      fi

      "$action" "$@"
