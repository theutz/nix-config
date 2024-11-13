{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod}.enable = lib.mkEnableOption mod;

  config.${namespace}.${mod} = lib.mkIf cfg.enable {};
}
