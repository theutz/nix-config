{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.internal.zk;

  tomlFormat = pkgs.formats.toml {};
in {
  options.internal.zk = {
    enable = lib.mkEnableOption "zk";

    settings = lib.mkOption {
      inherit (tomlFormat) type;
      description = ''
        Configuration defined at https://zk-org.github.io/zk/config/config.html.
      '';
      default = {
        notebook = {
          dir = "~/notes";
        };

        note = {
          language = "en";
        };

        extra = {
          user = config.home.username;
        };

        tool = {
          editor = config.home.sessionVariables.EDITOR;
          shell = lib.getExe pkgs.zsh;
        };

        alias = {
          ls = "zk list --quiet --format path --no-pager $@";
          e = "zk edit --interactive";
          edlast = "zk edit --limit 1 --sort modified- $@";
          rm = "zk ls -0 $@ | fzf --read0 --print0 -m | xargs -0 rm";
          commit = "git add -A && git commit -m '$*'";
          sync = "zk commit '$*' && git pull && git push";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      zk
    ];

    xdg.configFile."zk/config.toml" = {
      source = tomlFormat.generate "zk-config" cfg.settings;
    };
  };
}
