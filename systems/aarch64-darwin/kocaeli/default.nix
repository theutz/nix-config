{
  pkgs,
  lib,
  ...
}: {
  imports = lib.pipe ./. [
    lib.filesystem.listFilesRecursive
    (lib.filter (f: f != ./default.nix))
  ];

  internal = {
    home-manager.enable = true;
    homebrew.enable = true;
    jankyborders.enable = true;
  };

  programs = {
    zsh.enable = true;
  };
}
