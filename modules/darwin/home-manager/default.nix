{
  lib,
  namespace,
  config,
  ...
}: let
  mod = lib.pipe ./. [lib.path.splitRoot (lib.getAttr "subpath") lib.path.subpath.components lib.last];
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
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
