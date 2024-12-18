{
  pkgs,
  lib,
  inputs,
  system,
  namespace,
  ...
}:
with lib; let
  inherit (inputs.darwin.packages.${system}) darwin-rebuild;

  name = lib.${namespace}.path.getLastComponent ./.;

  description = "Commands for working with my nix-config";

  args = {
    inherit pkgs lib darwin-rebuild namespace;
    main = name;
  };

  commands = rec {
    switch = import ./switch.nix (args // {inherit build;});
    goto = import ./goto.nix args;
    watch = import ./watch.nix (args // {inherit switch;});
  };
in
  pkgs.writeShellApplication rec {
    inherit name;

    meta = {
      inherit description;
    };

    runtimeInputs =
      (with pkgs; [
        gum
      ])
      ++ (lib.attrValues commands);

    text =
      builtins.readFile
      (pkgs.replaceVars ./default.sh
        {
          inherit name;
          inherit (meta) description;
          inherit (lib.${namespace}.bash) loggers;

          flake-path = lib.${namespace}.vars.paths.flake;

          actions = lib.pipe commands [
            (lib.mapAttrsToList
              (_: p: "${lib.getName p}"))
            (lib.concatStringsSep " | ")
          ];

          help-actions = lib.pipe commands [
            (lib.mapAttrsToList
              (_: p: {
                name = lib.getName p;
                desc = p.meta.description or "";
              }))

            (lib.concatMapStrings (p: ''
              - `${p.name}`: ${p.desc}
            ''))
          ];
        });
  }
