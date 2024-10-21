{
  lib,
  config,
  namespace,
  ...
}: let
  mod = lib.theutz.modules.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "ripgrep";
  };

  config = lib.mkIf cfg.enable {
    programs.ripgrep = {
      enable = true;
      arguments = [];
    };
  };
}
