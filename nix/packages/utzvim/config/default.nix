{lib, ...}: let
  filesIn = dir:
    assert (lib.isPath dir);
      lib.pipe dir [
        builtins.readDir
        (lib.filterAttrs
          (k: v:
            v == "regular" && k != "default.nix"))
        lib.attrNames
        (lib.map
          (f: lib.path.append dir f))
      ];
  importDirs = [./. ./modules ./plugins];
in {
  imports =
    lib.pipe importDirs
    [
      (lib.map filesIn)
      lib.flatten
    ];
}
