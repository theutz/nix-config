{pkgs, ...}:
pkgs.writeShellApplication {
  name = "find-root";

  meta = {
    description = "Given a file, find the nearest parent folder";
    longDescription = ''
      Usage: find-root "flake.lock"
    '';
  };

  text = ''
    function find-root-with-file() {
      if [[ -f "$1" ]]; then
        printf "%s\n" "$PWD"
      elif [[ "$PWD" == "/" ]]; then
        false
      else
        (cd .. && find-root-with-file "$1")
      fi
    }

    find-root-with-file "$1"
  '';
}
