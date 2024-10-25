{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib; let
  mod = pipe ./. [
    path.splitRoot
    (getAttr "subpath")
    path.subpath.components
    last
  ];
  cfg = config."${namespace}"."${mod}";

  relToDotDir = file:
    (optionalString (config.programs.zsh.dotDir != null)
      (config.programs.zsh.dotDir + "/"))
    + file;

  login = pipe "${pkgs.zsh-prezto}/share/zsh-prezto/runcoms/zlogin" [
    readFile
    (
      text:
        if (elem pkgs.fortune-kind config.home.packages)
        then (strings.replaceStrings ["fortune -s"] ["fortune"] text)
        else text
    )
  ];
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
    home.file."${relToDotDir ".zlogin"}".text = mkForce login;

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
