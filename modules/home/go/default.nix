{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  mod = lib.internal.path.getLastComponent ./.;
  cfg = config.internal.${mod};
in {
  options.internal.${mod} = {
    enable = lib.mkEnableOption "golang";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      golangci-lint
      golangci-lint-langserver
    ];

    programs.go = {
      enable = true;
    };
  };
}
