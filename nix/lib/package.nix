{lib, ...}: rec {
  toMarkdown = pkg @ {
    name,
    meta,
    ...
  }: ''- `${name}`: ${pkg.meta.description}'';

  listToMarkdown = pkgs:
    lib.strings.concatStringsSep
    "\n"
    (lib.lists.map toMarkdown pkgs);
}
