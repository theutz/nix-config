{
  config,
  namespace,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkMerge;
  inherit (lib.${namespace}) mkIfInstalled';
  mkIfInstalled = mkIfInstalled' config;

  mod = "zsh";
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = mkEnableOption "the zshell";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      shellAliases = mkMerge [
        (mkIf config.programs.lazygit.enable {
          lg = "lazygit";
        })
        (mkIfInstalled pkgs.speedtest-rs {
          speedtest = "speedtest-rs";
        })
        (mkIfInstalled pkgs.speedtest-go {
          speedtest = "speedtest-go";
        })
      ];

      initExtra =
        /*
        bash
        */
        ''
          setopt NO_EXTENDED_GLOB NO_INTERACTIVE_COMMENTS

          PATH="$(
            echo "$PATH" |
              tr ':' '\n' |
              grep -v "/opt/homebrew/" |
              paste -sd ':'
          )"

          PATH="$(
            echo "$PATH" |
              awk -v RS=: -v ORS=: '{
                if ($0 == "/usr/bin") {
                  print "/opt/homebrew/bin:/opt/homebrew/sbin:" $0
                } else {
                  print $0
                }
              }' |
              sed 's/:$//'
          )"

          export PATH

          if [[ ! -v OPENAI_KEY && -n "$TMUX" ]]; then
            tmux setenv -g OPENAI_KEY "$(op read --account ${namespace}.1password.com "op://Private/OpenAI API Key/api key")"
            tmux setenv -g OPENAI_API_KEY "$OPENAI_KEY"
          fi
        '';
    };
  };
}
