{
  pkgs,
  lib,
  ...
}: let
  template =
    /*
    nix
    */
    ''
      {
        lib,
        config,
        namespace,
        ...
      }: let
        mod = lib.internal.path.getLastComponent ./.;
        cfg = config.internal.''${mod};
      in {
        options.internal.''${mod} = {
          enable = lib.mkEnableOption mod;
        };

        config = lib.mkIf cfg.enable {
        };
      }
    '';

  description = "Create a blank home manager module";

  name = with lib;
    pipe ./. [
      path.splitRoot
      (getAttr "subpath")
      path.subpath.components
      last
    ];

  usage = ''
    ${description}

    usage:
        ${name} <module name>

    flags:
        --help, -h        show this help
  '';
in
  pkgs.writeShellApplication {
    inherit name;

    meta = {inherit description;};

    runtimeInputs = with pkgs; [
      gum
      internal.find-root
    ];

    runtimeEnv = {
      HOME_MODULES_DIR = lib.internal.vars.paths.homeModules;
    };

    text = ''
      function help() {
        echo '${usage}'
      }

      args=()
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --help|-h)
            help
            exit 0
            ;;
          --*|-*)
            help
            exit 1
            ;;
          *)
            args+=("$1")
            shift
            ;;
        esac
      done
      set -- "''${args[@]}"

      if [[ -n "$1" ]]; then
        module_name="$1"
      else
        module_name="$(gum input --header="New module name")"
      fi

      full_path="$HOME/$HOME_MODULES_DIR/$module_name/default.nix"

      if gum confirm "Create file at $full_path?"; then
        mkdir -p "$(dirname "$full_path")"
        # shellcheck disable=2016
        echo '${template}' > "$full_path"
        gum log -l info "New module at" file "$full_path"
      else
        exit 1
      fi

      if gum confirm "Open in $EDITOR?"; then
        "$EDITOR" "$full_path"
      fi
    '';
  }