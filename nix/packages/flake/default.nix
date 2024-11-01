{
  pkgs,
  lib,
  inputs,
  namespace,
  system,
  ...
}:
with lib; let
  inherit (inputs.darwin.packages.${system}) darwin-rebuild;

  name = lib.${namespace}.path.getLastComponent ./.;

  description = "Commands for working with my nix-config";

  args = {
    inherit pkgs lib darwin-rebuild loggers;
    main = name;
  };

  build = import ./build.nix args;
  switch = import ./switch.nix (args // {inherit build;});

  watch = pkgs.writeShellApplication {
    name = "watch";

    meta.description = "Watch for changes and reload.";

    runtimeInputs =
      [switch]
      ++ (with pkgs; [
        watchexec
      ]);

    text = ''
      cd "$MY_FLAKE_DIR"
      watchexec --clear --restart --notify -- switch
    '';
  };

  commands = {
    inherit build watch switch;
    goto = import ./goto.nix args;
  };

  usage = ''
    # ${name}

    ${description}

    ## Commands

    | Name | Description |
    | :--- | :---        |
    ${lib.concatLines (lib.mapAttrsToList (_: cmd: ''
      | ${lib.getName cmd} | ${cmd.meta.description or ""} |'')
    commands)}
  '';

  loggers =
    /*
    bash
    */
    ''
      function fatal () {
        gum log -l fatal -s "$@"
      }

      function error () {
        gum log -l error -s "$@"
      }

      function warn () {
        gum log -l warn -s "$@"
      }

      function info () {
        gum log -l info -s "$@"
      }

      function debug () {
        gum log -l debug -s "$@"
      }
    '';
in
  pkgs.writeShellApplication {
    inherit name;

    meta = {
      inherit description;
    };

    runtimeInputs =
      (with pkgs; [
        gum
      ])
      ++ (lib.attrValues commands);

    text = ''
      MY_FLAKE_DIR="$HOME/${lib.${namespace}.vars.paths.flake}"
      export MY_FLAKE_DIR

      function help () {
        gum format <<-'EOF'
        ${usage}
      EOF
      }

      ${loggers}

      action=""
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

      if [[ -n "$action" ]]; then
        "$action" "$@"
      fi
    '';
  }
