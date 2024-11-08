{
  config,
  lib,
  pkgs,
  ...
}: let
  mod = "wezterm";
  cfg = config.internal.${mod};
in {
  options.internal.${mod} = {
    enable = lib.mkEnableOption "wezterm terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      extraConfig = builtins.readFile (pkgs.replaceVars ./wezterm.lua (let
        inherit (lib.internal.vars.styles) font;
      in {
        font-family = font.family;
        font-weight = font.weight;
        font-size = font.size;
        font-leading = font.leading;
      }));
    };
  };
}
