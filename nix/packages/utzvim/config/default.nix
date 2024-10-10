{lib, ...}: let
  inherit (lib.filesystem) listFilesRecursive;
  inherit (builtins) filter;
in {
  imports = let
    files = listFilesRecursive ./.;
    notDefaultFrom = f: f != ./default.nix;
  in
    filter notDefaultFrom files;
}
