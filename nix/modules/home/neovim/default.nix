{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  inherit (config.lib.file) mkOutOfStoreSymlink;

  mod = "neovim";
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = mkEnableOption "neovim with lazyvim";
  };

  config = mkIf cfg.enable {
    xdg.configFile."nvim" = {
      recursive = false;
      source = mkOutOfStoreSymlink ./config;
    };
  };
}
