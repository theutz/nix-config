{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.internal.nb;
in {
  options.internal.nb = {
    enable = lib.mkEnableOption "nb";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [nb];

    xdg.configFile."nbrc".source =
      config.lib.file.mkOutOfStoreSymlink
      (lib.traceValSeq (lib.path.subpath.join [
        lib.internal.vars.paths.homeModules
        (builtins.baseNameOf ./nbrc.sh)
      ]));
  };
}
