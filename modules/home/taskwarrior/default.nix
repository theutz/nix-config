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

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      timewarrior
      tasksh
      vit
    ];

    programs.taskwarrior = {
      enable = true;
      config = {};
    };

    xdg.configFile."timewarrior/timewarrior.cfg".text = ''
      reports.summary.annotations = yes
      reports.summary.ids = yes
      tags.Delegator.description = Work tasks for Delegator, LLC
      tags.Work.description = Any tasks related to making money
      tags.Meetings.description = Zoom calls, in-person meetings, or whatever
      tags.StatusCall.description = Weekly update call with Delegator's Creative & Web Team
      tags.LocalDev.description = Any tasks related to setting up local dev environments
      reports.summary.range = week
    '';
  };
}
