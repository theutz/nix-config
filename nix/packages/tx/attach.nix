{
  pkgs,
  lib,
  namespace,
  ...
}: let
  root = lib.${namespace}.path.getLastComponent ./.;
  name = "attach";
  description = "Start or attach to a session";
in
  pkgs.writeShellApplication {
    inherit name;

    meta = {inherit description;};

    runtimeInputs = with pkgs; [gum];

    text = pkgs.replaceVars ./attach.sh {
      inherit
        name
        root
        description
        ;
    };
  }
