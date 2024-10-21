{
  mkShell,
  pkgs,
  lib,
  ...
} @ inputs: let
  inherit (lib) forEach concatStringsSep;
  inherit (lib.filesystem) listFilesRecursive;
  scripts = forEach (listFilesRecursive ./scripts) (f: import f inputs);
  descriptions = concatStringsSep "\n" (forEach scripts (s: ''- `${s.name}`: ${s.meta.description}''));
in
  mkShell {
    packages =
      [
        pkgs.gum
      ]
      ++ scripts;

    shellHook = ''
      gum format <<'EOF'
      # Welcome to TheUtz's Flake ❄️

      ## Commands

      ${descriptions}
      EOF
    '';
  }
