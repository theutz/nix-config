{
  config,
  lib,
  ...
}: let
  inherit (config.plugins) noice;
in {
  plugins.lsp-signature = lib.mkIf (! noice.enable) {
    enable = true;
  };
}
