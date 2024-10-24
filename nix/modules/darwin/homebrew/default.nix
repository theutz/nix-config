{
  config,
  lib,
  namespace,
  ...
}: let
  mod = lib.pipe ./. [
    lib.path.splitRoot
    (lib.getAttr "subpath")
    lib.path.subpath.components
    lib.last
  ];
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "homebrew";
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;

      casks = [
        "aerospace"
      ];
    };
  };
}
