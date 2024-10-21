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
        mod = lib.theutz.modules.getLastComponent ./.;
        cfg = config.''${namespace}.''${mod};
      in {
        options.''${namespace}.''${mod} = {
          enable = lib.mkEnableOption "''${mod}";
        };

        config = lib.mkIf cfg.enable {
        };
      }
    '';
in
  pkgs.writeShellApplication rec {
    name = lib.last (lib.path.subpath.components (lib.path.splitRoot ./.).subpath);

    meta = {
      description = "Create a blank home manager module";
      longDescription = ''
        usage: ${name} <module name>

        flags:
            --help, -h        show this help
      '';
    };

    runtimeInputs =
      (with pkgs; [
        gum
      ])
      ++ (with pkgs.theutz; [
        find-root
        print-path-to-home-modules
      ]);

    text = ''
      function help() {
        cat <<-'EOF'

      ${meta.description}

      ${meta.longDescription}
      EOF
      }

      module_name=""

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
            module_name="$1"
            break
        esac
      done

      if [[ -z "$module_name" ]]; then
        module_name="$(gum input --header="New module name")"
      fi

      full_path="$(print-path-to-home-modules)/$module_name/default.nix"

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
