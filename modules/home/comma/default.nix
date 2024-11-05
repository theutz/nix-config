{
  lib,
  config,
  namespace,
  ...
}: let
  mod = "comma";
  cfg = config.internal.${mod};
in {
  options.internal.${mod} = {
    enable = lib.mkEnableOption "comma, nix-index, nix-index-database";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-index = {
      enable = true;
    };

    programs.nix-index-database.comma.enable = true;
  };
}
