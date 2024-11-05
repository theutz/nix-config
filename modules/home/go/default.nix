{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  mod = lib.${namespace}.path.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
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
