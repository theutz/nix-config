{lib, ...}: let
  toMarkdown = pkg:
    "- **${lib.getName pkg}**"
    + lib.optionalString (pkg.meta ? description) "\n  - ${pkg.meta.description}";

  pipe = lib.flip lib.pipe;

  makeTableRow = pipe [
    (lib.splitString ", ")
    (lib.strings.concatImapStringsSep "|" (i: v:
      if i == 1
      then "| --${v}"
      else if i == 2
      then "-${v}"
      else if i == 3
      then "${v} |"
      else throw "No more than 3 items"))
  ];
in {
  listToMarkdown =
    lib.strings.concatMapStringsSep
    "\n"
    toMarkdown;

  flags = {
    toMarkdown = pipe [
      (lib.map makeTableRow)
      (lib.concat [
        "| Long | Short | Description |"
        "| :--- | :--- | :--- |"
      ])
      lib.concatLines
    ];
  };
}
