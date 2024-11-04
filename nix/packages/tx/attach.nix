{
  pkgs,
  lib,
  namespace,
  ...
}: let
  name = "attach";
  description = "Start or attach to a session";
  help =
    /*
    markdown
    */
    ''

    '';
in
  pkgs.writeShellApplication {
    inherit name;

    meta = {inherit description;};

    runtimeInputs = with pkgs; [gum];

    text = ''
      function help () {
        gum format <<-'EOF'
      ${help}
      EOF
      }
    '';
  }
