{lib, ...}: {
  /*
  Return the last component of a path as a string.
  */
  getLastComponent = let
    inherit (lib) last getAttr;
    inherit (lib.path) splitRoot;
    inherit (lib.path.subpath) components;
  in
    path: last (components (getAttr "subpath" (splitRoot path)));
}
