{
  lib,
  config,
  namespace,
  pkgs,
  osConfig,
  ...
}: let
  mod = lib.theutz.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "${mod}";
  };

  config = lib.mkIf cfg.enable {
    launchd.enable = true;

    home.packages = with pkgs; [
      sketchybar
      coreutils
      gnugrep
    ];

    xdg.configFile.sketchybar = {
      recursive = true;
      source = ./sketchybar;
    };

    launchd.agents.sketchybar = {
      enable = true;
      config = {
        ProgramArguments = [
          ''${pkgs.sketchybar}/bin/sketchybar''
        ];
        EnvironmentVariables = {
          LANG = "en_US.UTF-8";
          PATH = lib.concatStringsSep ":" [
            ''${config.home.profileDirectory}/bin''
            ''${osConfig.system.profile}/sw/bin''
            ''${osConfig.homebrew.brewPrefix}/bin''
            "/usr/bin"
          ];
        };
        ProcessType = "Interactive";
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "${config.xdg.dataHome}/sketchybar/sketchybar.out.log";
        StandardErrorPath = "${config.xdg.dataHome}/sketchybar/sketchybar.err.log";
      };
    };
  };
}