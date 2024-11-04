{
  pkgs,
  lib,
  namespace,
  ...
} @ args: let
  name = lib.${namespace}.path.getLastComponent ./.;

  description = "Toolkit for working with tmux and tmuxp";

  cmds = [
    (import ./edit.nix args)
  ];

  help =
    /*
    markdown
    */
    ''
      # ${name}

      ${description}.

      ## Usage

      ```
      ${name} [SUBCOMMAND] [FLAGS]
      ```

      ### Flags

      | Long   | Short | Description    |
      | :---   | :---  | :---           |
      | --help | -h    | show this help |

      ### Subcommands

      ${lib.pipe cmds [
        (lib.map (cmd: ''
          - **${lib.getName cmd}**
            - ${cmd.meta.description}
        ''))
        lib.concatLines
      ]}
    '';
in
  pkgs.writeShellApplication {
    inherit name;

    meta = {
      inherit description;
    };

    runtimeInputs =
      (with pkgs; [
        bashInteractive
        gum
        tmux
        tmuxp
      ])
      ++ cmds;

    text = ''
      TMUX_CONFIG_DIR="$HOME/${lib.${namespace}.vars.paths.tmux}"
      export TMUX_CONFIG_DIR

      TMUXP_CONFIG_DIR="$HOME/${lib.${namespace}.vars.paths.tmuxp}"
      export TMUXP_CONFIG_DIR

      function help () {
        gum format --type=markdown <<-'EOF'
      ${help}
      EOF
      echo
      }

      args=()
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --help | -h)
            show_help=true
            shift 1
            ;;
          ${lib.concatStringsSep " | " (lib.forEach cmds lib.getName)})
            action="$1"
            shift 1
            ;;
          --* | -*)
            gum log -l error "$1: flag not recognized"
            gum log -l fatal "exiting"

            ;;
          *)
            args+=("$1")
            shift 1
            ;;
        esac
      done

      if [[ ! -v action && ! -v show_help ]]; then
        gum log -l error "no arguments provided"
        gum log -l fatal "exiting"
      fi

      if [[ ! -v action && -v show_help ]]; then
        help
        exit 0
      fi

      if [[ -v action && -v show_help ]]; then
        args+=("--help")
      fi

      set -- "''${args[@]}"

      "$action" "$@"
    '';
  }
