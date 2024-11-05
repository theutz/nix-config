{
  lib,
  namespace,
  config,
  ...
}: let
  mod = lib.pipe ./. [lib.path.splitRoot (lib.getAttr "subpath") lib.path.subpath.components lib.last];
  cfg = config.internal.${mod};
in {
  options.internal.${mod} = {
    enable = lib.mkEnableOption "home-manager";
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      backupFileExtension = "backup";
      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
