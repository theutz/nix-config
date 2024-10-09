{
  pkgs,
  lib,
  inputs,
  system,
  ...
}: let
  name = lib.theutz.getLastComponent ./.;
  unstable = inputs.unstable.legacyPackages.${system};
in
  pkgs.writeShellApplication {
    inherit name;

    runtimeInputs = [
      unstable.fzf
      pkgs.tmuxp
      pkgs.yq
      pkgs.tmux
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
