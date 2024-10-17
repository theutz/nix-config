{
  config,
  lib,
  namespace,
  ...
}: let
  mod = lib.theutz.getLastComponent ./.;
  cfg = config.${namespace}.${mod};
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "fzf fuzzy finder";
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = lib.mkMerge [
      {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;

        defaultOptions = [
          "--height 40%"
          "--layout reverse"
          "--border top"
          "--bind 'ctrl-d:preview-half-page-down'"
          "--bind 'ctrl-u:preview-half-page-up'"
          "--color='bg:0,fg:7,hl:3'"
          "--color='bg+:8,fg+:4,hl+:9'"
          "--color='info:3,border:3,prompt:4'"
          "--color='pointer:0,marker:9,spinner:9,header:1'"
        ];

        tmux.enableShellIntegration = true;
      }
      (lib.mkIf config.programs.fd.enable {
        changeDirWidgetCommand = "fd --type d";
        defaultCommand = "fd --type f";
        fileWidgetCommand = "fd --type f";
      })
    ];
  };
}
