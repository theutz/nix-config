_: {
  config = {
    programs.zsh.enable = true;

    programs.zsh.prezto = {
      enable = true;

      extraFunctions = ["zargs" "zmv"];
      extraModules = ["attr" "stat"];

      pmodules = [
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
          "builtin"  = "fg=magenta";
          "command"  = "fg=green";
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

      tmux = {
        autoStartLocal = true;
        autoStartRemote = true;
        defaultSessionName = "main";
      };

      utility.safeOps = true;
    };
  };
}
