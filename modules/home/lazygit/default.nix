{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  mod = "lazygit";
  cfg = config."internal"."${mod}";
in {
  options."internal"."${mod}" = {
    enable = mkEnableOption "manage zsh and prezto";
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          expandFocusedSidePanel = true;
          showRandomTip = false;
          showCommandLog = true;
          showBottomLine = false;
          nerdFontsVersion = "3";
          border = "rounded";
        };
        git = {
          parseEmoji = true;
          commit = {
            signOff = true;
          };
          paging = {
            colorArg = "always";
            pager = ''
              delta "$(dark-mode status | grep on && echo "--dark" || echo "--light")" --paging=never
            '';
          };
        };
        notARepository = "skip";
        promptToReturnFromSubprocess = false;
        disableStartupPopups = true;
        customCommands = [
          {
            key = "b";
            context = "files";
            command = "aicommits";
            description = "aicommits";
            subprocess = true;
            showOutput = true;
          }
          {
            key = "z";
            command = "git cz c";
            description = "commit with commitizen";
            context = "files";
            loadingText = "opening commitizen commit tool";
            subprocess = true;
          }
          {
            key = "E";
            description = "Add empty commit";
            context = "commits";
            command = ''
              'git commit --allow-empty -m "chore: empty commit"'
            '';
            loadingText = "Committing empty commit...";
          }
        ];
      };
    };

    home.shellAliases = {
      lg = "lazygit";
    };
  };
}
