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
      (lib.traceVal (lib.path.append (/. + config.home.homeDirectory)
        (lib.path.subpath.join [
          lib.internal.vars.paths.homeModules
          (lib.internal.path.getLastComponent ./.)
          (builtins.baseNameOf ./nbrc.sh)
        ])));
  };
}
