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

          export PATH="$(
            echo $PATH |
              tr ':' '\n' |
              grep -v "/opt/homebrew/" |
              paste -sd ':'
          )"
        '';
    };
  };
}
