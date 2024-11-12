{
  pkgs,
  lib,
  main,
  darwin-rebuild,
  ...
}:
with lib; let
  name = "build";
  description = "Build the current flake in `./result`";
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

      | Long     | Short | Description                            |
      | :------- | :---- | :------------------------------------- |
      | --help   | -h    | show this help                         |
      | --no-add |       | don't run `git add -A` before building |
    '';
in
  pkgs.writeShellApplication {
    inherit name;

    meta = {
      inherit description;
    };

    runtimeInputs = with pkgs; [
      gum
      git
      darwin-rebuild
      yazi
    ];

    text = ''
      ${lib.internal.bash.loggers}

      function help() {
        gum format <<-'EOF'
        ${usage}
      EOF
      }

      add_git_files=true

      args=()
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --help|-h)
            help
            exit 0
            ;;
          --no-add)
            add_git_files=false
            git add -A
            shift 1
            ;;
          *)
            fatal "argument not recognized: $1"
            exit 1
            ;;
        esac
      done
      set -- "''${args[@]}"

      (
        cd "$MY_FLAKE_DIR"

        if "$add_git_files"; then
          git add -A
        fi

        darwin-rebuild build --flake .
      )
    '';
  }
