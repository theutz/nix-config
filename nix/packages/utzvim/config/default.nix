{lib, ...}: let
  inherit (builtins) readDir;
  inherit (lib) pipe filterAttrs attrNames map path elem mapAttrsToList concatLists;

  mainFiles = pipe ./. [
    readDir

    (filterAttrs
      (name: type:
        type == "regular" && name != "default.nix"))

    attrNames

    (map
      (path.append ./.))
  ];

  modules = pipe ./modules [
    builtins.readDir

    (filterAttrs
      (_: type:
        type == "regular"))

    attrNames

    (map
      (path.append ./modules))
  ];

  plugins = pipe ./plugins [
    readDir

    (filterAttrs
      (_: type: (elem type ["regular" "directory"])))

    (mapAttrsToList
      (name: type: (
        if type == "directory"
        then (path.subpath.join [name "default.nix"])
        else name
      )))

    (map (path.append ./plugins))
  ];
in {
  imports = concatLists [
    mainFiles
    modules
    plugins
  ];
}
