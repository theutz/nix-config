{lib, ...}: let
  /*
  Return the last component of a path as a string.
  */
  getLastComponent = let
    inherit (lib) last getAttr;
    inherit (lib.path) splitRoot;
    inherit (lib.path.subpath) components;
  in
    path: last (components (getAttr "subpath" (splitRoot path)));

  /*
  Return the name of the module from the directory name
  */
  getModName = path: getLastComponent path;

  /*
  Return the path array to be used with {get,set}Attrs{From,By}Path
  */
  getModPath = namespace: path: [namespace getModName path];
in {
  inherit getLastComponent getModName getModPath;
}
