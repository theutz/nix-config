{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkOption types mkMerge;

  mod = "prezto";
  cfg = config."${namespace}"."${mod}";
in {
  options."${namespace}"."${mod}" = {
    enable = mkEnableOption "prezto zsh framework";
    autoTmux = mkOption {
      default = true;
      description = ''
        Turn off to disable automatic tmux sessions
        for both local and remote terminals.
      '';
      example = ''
        ${namespace}.${mod}.autoTmux = false;
      '';
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    programs.zsh.prezto = {
      enable = true;

      extraFunctions = ["zargs" "zmv"];
      extraModules = ["attr" "stat"];

      pmodules = mkMerge [
        [
          "environment"
          "terminal"
          "editor"
          "history"
          "directory"
          "spectrum"
          "tmux"
          "homebrew"
          "archive"
          "rsync"
          "command-not-found"
          "docker"
          "osx"
          "git"
          "utility"
          "ssh"
          "completion"
          "syntax-highlighting"
          "history-substring-search"
          "autosuggestions"
        ]
        (mkIf (! config.programs.starship.enable) [
          "prompt"
        ])
      ];

      autosuggestions = {
        color = "fg=cyan";
      };

      editor = {
        keymap = "vi";
        dotExpansion = false;
      };

      gnuUtility.prefix = "g";

      syntaxHighlighting = {
        highlighters = [
          "main"
          "brackets"
          "pattern"
          "line"
          "cursor"
          "root"
        ];

        styles = {
          "builtin" = "fg=magenta";
          "command" = "fg=green";
          "function" = "bg=blue";
        };

        pattern = {
          "rm*-rf*" = "fg=white,bold,bg=red";
        };
      };

      terminal = {
        autoTitle = true;
        windowTitleFormat = "%n@%m: %s";
        tabTitleFormat = "%m: %s";
        multiplexerTitleFormat = "%s";
      };

      tmux = mkMerge [
        {
          defaultSessionName = "main";
        }
        (mkIf cfg.autoTmux {
          autoStartLocal = true;
          autoStartRemote = true;
        })
      ];

      utility.safeOps = true;
    };
  };
}
