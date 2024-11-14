{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  mod = lib.pipe ./. [
    lib.path.splitRoot
    (lib.getAttr "subpath")
    lib.path.subpath.components
    lib.last
  ];
  cfg = config."${namespace}"."${mod}";

  relToDotDir = file:
    (lib.optionalString (config.programs.zsh.dotDir != null)
      (config.programs.zsh.dotDir + "/"))
    + file;

  zlogin =
    /*
    bash
    */
    ''
      {
        zcompdump="''${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump"
        if [[ -s "$zcompdump" && (! -s "''${zcompdump}.zwc" || "$zcompdump" -nt "''${zcompdump}.zwc") ]]; then
          if command mkdir "''${zcompdump}.zwc.lock" 2>/dev/null; then
            zcompile "$zcompdump"
            command rmdir "''${zcompdump}.zwc.lock" 2>/dev/null
          fi
        fi
      } &!

      if [[ -o INTERACTIVE && -t 2 ]]; then
        if (( $+commands[timew] )); then
          timew day
        fi
      fi
    '';

  zlogout =
    /*
    bash
    */
    ''
      [[ -o INTERACTIVE && -t 2 ]] && {
        SAYINGS=(
          "Loves 'ya!"
          "Did you like de song?"
        )

        cowsay $SAYINGS[$(($RANDOM % ''${#SAYINGS} + 1))] | lolcat
      } >&2
    '';
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "prezto zsh framework";

    autoTmux = lib.mkOption {
      default = true;

      description = ''
        Turn off to disable automatic tmux sessions
        for both local and remote terminals.
      '';

      example = ''
        ${namespace}.${mod}.autoTmux = false;
      '';

      type = lib.types.bool;
    };
  };

  config = lib.mkIf cfg.enable {
    home.file."${relToDotDir ".zlogin"}".text = lib.mkForce zlogin;
    home.file.${relToDotDir ".zlogout"}.text = lib.mkForce zlogout;

    home.packages = with pkgs; [
      lolcat
      cowsay
    ];

    programs.zsh.prezto = {
      enable = true;

      extraFunctions = ["zargs" "zmv"];
      extraModules = ["attr" "stat"];

      pmodules = lib.mkMerge [
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
        (lib.mkIf (! config.programs.starship.enable) [
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

      tmux = lib.mkMerge [
        {
          defaultSessionName = "main";
        }
        (lib.mkIf cfg.autoTmux {
          autoStartLocal = true;
          autoStartRemote = true;
        })
      ];

      utility.safeOps = true;
    };
  };
}
