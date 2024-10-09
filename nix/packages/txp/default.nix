{
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) baseNameOf;
  inherit (lib) removeSuffix;

  name = removeSuffix ".nix" (baseNameOf ./.);
in
  pkgs.writeShellApplication {
    inherit name;

    runtimeInputs = with pkgs; [
      fzf
      tmuxp
    ];

    text = ''
      positional_args=();
      action=""

      while [[ $# -gt 0 ]]; do
        case $1 in
          -e|--edit)
            action="edit"
            shift
            ;;
          -l|--load)
            action="load"
            shift
            ;;
          *)
            positional_args+=("$1")
            shift
        esac
      done

      set -- "''${positional_args[@]}"

      if [[ -n "$action" ]]; then
        tmuxp ls | fzf | xargs -I _ tmuxp "$action" _ "$@"
      else
        tmuxp "$@"
      fi
    '';
  }
