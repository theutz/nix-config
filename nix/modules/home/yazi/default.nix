{
  lib,
  config,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  mod = "yazi";
  cfg = config.${namespace}.${mod};

  y = ''
    function y() {
    	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    	yazi "$@" --cwd-file="$tmp"
    	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    		builtin cd -- "$cwd"
    	fi
    	rm -f -- "$tmp"
    }
  '';
in {
  options.${namespace}.${mod} = {
    enable = mkEnableOption "yazi file manager";
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;

      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    programs.zsh.initExtra = y;
    programs.bash.initExtra = y;
  };
}
