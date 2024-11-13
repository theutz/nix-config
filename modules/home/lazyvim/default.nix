{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod}.enable = lib.mkEnableOption mod;

  config = lib.mkIf cfg.enable {
    "${namespace}".neovim = {
      enable = true;
      package = pkgs.neovim;
      enableManIntegration = true;
    };
  };
}