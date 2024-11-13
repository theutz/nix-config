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
  cfg = config."internal"."${mod}";

  relToDotDir = file:
    (lib.optionalString (config.programs.zsh.dotDir != null)
      (config.programs.zsh.dotDir + "/"))
    + file;

  zlogin = lib.pipe "${pkgs.zsh-prezto}/share/zsh-prezto/runcoms/zlogin" [
    lib.readFile
    (lib.splitString "\n")
    (x: (lib.take ((lib.length x) - 11) x))
    lib.concatLines
  ];

  zlogout =
    /*
    bash
    */
    ''
      [[ -o INTERACTIVE && -t 2 ]] && {
        SAYINGS=(
          "Loves 'ya"
          "Did you like de song?"
        )

        cowsay $SAYINGS[$(($RANDOM % ''${#SAYINGS} + 1))] | lolcat -ai
      } >&2
    '';
in {
  options.internal.${mod} = {
    enable = lib.mkEnableOption "prezto zsh framework";

    autoTmux = lib.mkOption {
      default = true;

      description = ''
        Turn off to disable automatic tmux sessions
        for both local and remote terminals.
      '';

      example = ''
        internal.${mod}.autoTmux = false;
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
