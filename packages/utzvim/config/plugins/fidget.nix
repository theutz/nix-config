{
  config,
  lib,
  ...
}: let
  inherit (config.plugins) noice;
in {
  plugins.fidget = lib.mkIf (! noice.enable) {
    enable = true;
  };
}
