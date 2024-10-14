{lib, ...}: let
  modFns = import ./modules.nix {inherit lib;};
in
  lib.mergeAttrsList [modFns]
