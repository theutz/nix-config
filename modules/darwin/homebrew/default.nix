{
  config,
  lib,
  namespace,
  ...
}: let
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "homebrew";
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;
      brews = import ./brews.nix;
      casks = import ./casks.nix;
    };
  };
}
