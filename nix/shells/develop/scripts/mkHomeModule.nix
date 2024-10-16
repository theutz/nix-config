{pkgs, ...}: let
  description = "Create a blank home manager module";
  longDescription = ''
    usage: mkHomeModule [module name]
  '';
  template = ''
    {
      lib,
      config,
      namespace,
      ...
    }: let
      mod = lib.theutz.getLastComponent ./.;
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
  pkgs.writeShellApplication {
    name = "mkHomeModule";
    meta = {
      inherit longDescription description;
    };

    runtimeInputs = [
      pkgs.gum
      pkgs.theutz.find-root
    ];

    text = ''
      while [[ $# -gt 0 ]]; do
        case "$1" in
          --help|-h)
            printf "%s\n\n%s" "${description}" "${longDescription}"
            exit 1
            ;;
          *)
            module_name="$1"
            shift 1
        esac
      done

      project_root="$(find-root flake.lock)";
      path_to_home_modules="nix/modules/home";

      if [[ -z "$module_name" ]]; then
        module_name="$(gum input --header="New module name")"
      fi

      full_path="$project_root/$path_to_home_modules/$module_name/default.nix"

      if gum confirm "Create a new file at $full_path?"; then
        mkdir -p "$(dirname "$full_path")"
        # shellcheck disable=2016
        echo '${template}' > "$full_path"
        gum log -l info "New module at" file "$full_path"
      else
        exit 1
      fi

      if gum confirm "Open in editor?"; then
        "$EDITOR" "$full_path"
      fi
    '';
  }
