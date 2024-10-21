{
  pkgs,
  lib,
  ...
}: let
  name = lib.theutz.modules.getLastComponent ./.;
in
  pkgs.writeShellApplication {
    inherit name;

    runtimeInputs = [
      pkgs.tmuxp
      pkgs.yq
      pkgs.tmux
      pkgs.fzf
    ];

    text = ''
      filename=$(tmuxp ls | fzf --tmux=left,30)
      file="''${XDG_CONFIG_HOME:-$HOME/.config}"/tmuxp/"$filename".yml
      session=$(yq '.session_name' "$file")

      if ! tmux has -t "$session"; then
        tmuxp load -d "$filename"
      fi

      if [[ -n "$TMUX" ]]; then
        tmux switch-client -t "$session"
      else
        tmux attach-client -t "$session"
      fi
    '';
  }
