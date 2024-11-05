{
  config,
  lib,
  namespace,
  ...
}: let
  mod = lib.internal.path.getLastComponent ./.;
  cfg = config.internal.${mod};
in {
  options.internal.${mod} = {
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
