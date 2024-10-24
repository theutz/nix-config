{lib, ...}: rec {
  toMarkdown = pkg: let
    name = lib.strings.getName pkg;
    description = pkg.meta.description;
  in ''- `${name}`: ${description}'';

  listToMarkdown = pkgs:
    lib.strings.concatStringsSep
    "\n"
    (lib.lists.map toMarkdown pkgs);
}
