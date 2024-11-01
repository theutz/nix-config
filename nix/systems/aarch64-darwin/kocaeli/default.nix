{
  pkgs,
  lib,
  ...
}: {
  imports = lib.pipe ./. [
    lib.filesystem.listFilesRecursive
    (lib.filter (f: f != ./default.nix))
  ];

  theutz = {
    home-manager.enable = true;
    homebrew.enable = true;
    jankyborders.enable = true;
  };

  programs = {
    zsh.enable = true;
  };
}
