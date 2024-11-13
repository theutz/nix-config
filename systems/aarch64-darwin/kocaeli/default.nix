{
  namespace,
  lib,
  ...
}: {
  imports = lib.pipe ./. [
    lib.filesystem.listFilesRecursive
    (lib.filter (f: f != ./default.nix))
  ];

  "${namespace}" = {
    home-manager.enable = true;
    homebrew.enable = true;
    jankyborders.enable = true;
    nix.enable = true;
  };

  programs = {
    zsh.enable = true;
  };
}
