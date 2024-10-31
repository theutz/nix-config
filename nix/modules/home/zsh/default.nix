{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkMerge;

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
        '';
    };
  };
}
