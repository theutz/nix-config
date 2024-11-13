{
  pkgs,
  namespace,
  lib,
  ...
}: let
  template =
    /*
    nix
    */
    ''
      {
        pkgs,
        lib,
        ...
      }: pkgs.writeShellApplication rec {
        name = lib.last
          (lib.path.subpath.components
            (lib.path.splitRoot ./.).subpath);

        meta = {
          description = "";
          longDescription = ${"''"}
          ${"''"};
        };

        runtimeInputs = with pkgs; [
        ];

        text = ${"''"}
        ${"''"};
      }
    '';
in
  pkgs.writeShellApplication rec {
    name = lib.last (lib.path.subpath.components (lib.path.splitRoot ./.).subpath);

    meta = {
      description = "create a package in my local flake";
      longDescription = ''
        usage: mkPackage [package name]
      '';
    };

    runtimeInputs = with pkgs; [
      gum
    ];

    runtimeEnv = {
      PACKAGES_PATH = lib.${namespace}.vars.paths.packages;
    };

    text = ''
      function help () {
        cat <<'EOF'
      ${meta.description}

      ${meta.longDescription}
      EOF
      }

      package_name=""

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
            package_name="$1"
            break
        esac
      done

      function set-package-name () {
        if [[ -z "$package_name" ]]; then
          package_name="$(gum input --header "New package name")"
          set-package-name
        fi
      }
      set-package-name

      package_path="$HOME/$PACKAGES_PATH/$package_name/default.nix"

      if gum confirm "Create file at $package_path?"; then
        mkdir -p "$(dirname "$package_path")"
        cat <<-'EOF' > "$package_path"
      ${template}
      EOF
      else
        exit 1
      fi

      if gum confirm "Open in $EDITOR?"; then
        "$EDITOR" "$package_path"
      fi
    '';
  }
